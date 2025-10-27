import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/app_state.dart';
export 'spin_wheel_model.dart';
import '/backend/api_requests/api_calls.dart';

class SpinWheelWidget extends StatefulWidget {
  const SpinWheelWidget({super.key});

  @override
  State<SpinWheelWidget> createState() => _SpinWheelWidgetState();
}

class _SpinWheelWidgetState extends State<SpinWheelWidget>
    with SingleTickerProviderStateMixin {
  static const List<Color> colors = [
    Color(0xFF800080),
    Color(0xFFFF1493),
    Color(0xFFFFB6C1),
    Color(0xFFFF0000),
    Color(0xFFFF7F00),
    Color(0xFFFFD700),
    Color(0xFF90EE90),
    Color(0xFF008000),
    Color(0xFF00FFFF),
    Color(0xFF87CEFA),
    Color(0xFF0000FF),
    Color(0xFF4B0082),
  ];
  static final labels = List.generate(colors.length, (i) => "${(i + 1) * 50}");

  static const spinsKey = "spinWheel_spinsLeft";
  static const windowStartKey =
      "spinWheel_windowStartMs"; // epoch ms of first spin in current window
  static const windowDurationMs = 24 * 60 * 60 * 1000; // 24 hours

  int spinsLeft = 5;
  int? windowStartMs; // when the 24h window started (first spin time)
  int remainingSeconds = 0; // UI-only countdown when spins are exhausted
  bool isSpinning = false;
  String currentReward = "";

  double rotation = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  // Trigger backend crediting and show a congratulations message
  Future<void> _onRewardOkPressed() async {
    try {
      // Parse the numeric value from currentReward if needed (e.g., "150 Coins" -> 150)
      final match = RegExp(r"(\d+)").firstMatch(currentReward);
      final int amount = match != null ? int.parse(match.group(1)!) : 0;

      final response = await SpinWheelCall.call(
        token: FFAppState().token,
        amount: amount,
      );
      debugPrint(
          'SpinWheel API => status: ${response.statusCode}, body: ${response.bodyText}');

      if (!mounted) return;

      if (response.succeeded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Congratulations! $amount coins have been credited.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        // Try to show message from backend, else generic.
        String errMsg = 'Could not process your reward. Please try again.';
        final body = response.jsonBody;
        if (body is Map && body['message'] is String) {
          errMsg = body['message'];
        } else if (response.bodyText.isNotEmpty) {
          errMsg = response.bodyText;
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errMsg),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not process your reward. Please try again.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3500));
    _controller.addListener(() {
      setState(() {
        rotation = _animation.value;
      });
    });
    _startTimer();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSpins = prefs.getInt(spinsKey);
    final savedWindowStart = prefs.getInt(windowStartKey);

    final nowMs = DateTime.now().millisecondsSinceEpoch;
    int? startMs = savedWindowStart;
    int newSpins = savedSpins ?? 5;

    if (startMs != null) {
      final resetAt = startMs + windowDurationMs;
      if (nowMs >= resetAt) {
        // Window elapsed -> reset to full spins and clear window anchor
        startMs = null;
        newSpins = 5;
      }
    }

    // Migration from legacy logic: if no window anchor exists but stored spins < 5,
    // recover by resetting to 5 so users are not stuck without a countdown.
    if (startMs == null && (savedSpins != null && savedSpins < 5)) {
      newSpins = 5;
    }

    setState(() {
      spinsLeft = newSpins;
      windowStartMs = startMs;
      remainingSeconds = _computeRemainingSeconds(nowMs);
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(spinsKey, spinsLeft);
    if (windowStartMs == null) {
      await prefs.remove(windowStartKey);
    } else {
      await prefs.setInt(windowStartKey, windowStartMs!);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      final nowMs = DateTime.now().millisecondsSinceEpoch;

      // If there is an active window, check for reset
      if (windowStartMs != null) {
        final resetAt = windowStartMs! + windowDurationMs;
        if (nowMs >= resetAt) {
          setState(() {
            spinsLeft = 5;
            windowStartMs = null; // cleared; next spin will anchor new window
            remainingSeconds = 0;
          });
          _saveData();
          return;
        }
      }

      // Update countdown only when all spins are used
      final rs = _computeRemainingSeconds(nowMs);
      if (rs != remainingSeconds) {
        setState(() {
          remainingSeconds = rs;
        });
      }
    });
  }

  void _spin() {
    if (isSpinning || spinsLeft == 0) return;

    final random = Random();
    final randomOffset = random.nextDouble() * 360;
    const fullSpins = 5;
    final totalRotation = fullSpins * 360 + randomOffset;
    final startRotation = rotation;
    final endRotation = startRotation + totalRotation;

    _animation = Tween<double>(begin: startRotation, end: endRotation).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart),
    );

    setState(() {
      isSpinning = true;
      // Anchor window at the first spin if not already set
      windowStartMs ??= DateTime.now().millisecondsSinceEpoch;
      spinsLeft--;
    });
    _saveData();

    _controller.reset();
    _controller.forward();

    Future.delayed(const Duration(milliseconds: 3500), () {
      final segmentDegree = 360 / colors.length;
      final finalAngle = endRotation % 360;
      final pointerAngle = (360 - finalAngle + segmentDegree / 2) % 360;
      int index = (pointerAngle ~/ segmentDegree) % colors.length;
      index = (index - 4 + colors.length) % colors.length;

      setState(() {
        currentReward = "${labels[index]} Coins";
        isSpinning = false;
      });

      _saveData();
      _showRewardDialog();
    });
  }

  int _computeRemainingSeconds(int nowMs) {
    if (windowStartMs == null) return 0;
    final resetAt = windowStartMs! + windowDurationMs;
    final msLeft = resetAt - nowMs;
    if (msLeft <= 0) return 0;
    // Only show countdown when no spins are left
    return spinsLeft == 0 ? (msLeft / 1000).ceil() : 0;
  }

  void _showRewardDialog() {
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final baseScale =
        min(screenWidth, screenHeight) / 400; // Responsive scaling

    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: screenWidth * 0.8,
            padding: EdgeInsets.all(20 * baseScale),
            decoration: BoxDecoration(
              color: const Color(0xBB08162C),
              borderRadius: BorderRadius.circular(15 * baseScale),
              border: Border.all(
                color: const Color(0xFF00CFFF),
                width: 1 * baseScale,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.25),
                  blurRadius: 30 * baseScale,
                  spreadRadius: 5 * baseScale,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.amber, Colors.orange],
                  ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(
                    "Reward Unlocked!",
                    style: TextStyle(
                      fontSize: 24 * baseScale,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 15 * baseScale),
                Text(
                  "Congratulations! You have won:",
                  style:
                      TextStyle(color: Colors.white, fontSize: 16 * baseScale),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15 * baseScale),
                Text(
                  currentReward,
                  style: TextStyle(
                    fontSize: 28 * baseScale,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                    shadows: [
                      Shadow(
                          color: Colors.black54,
                          offset: Offset(2 * baseScale, 2 * baseScale),
                          blurRadius: 4 * baseScale)
                    ],
                  ),
                ),
                SizedBox(height: 20 * baseScale),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30 * baseScale)),
                  ),
                  onPressed: () async {
                    // Close the dialog first
                    Navigator.pop(context);
                    // Then trigger the backend action and show congratulations message
                    await _onRewardOkPressed();
                  },
                  child: Text("OK",
                      style: TextStyle(
                          fontSize: 18 * baseScale,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String _formatHMS(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    final s = seconds % 60;
    final hh = h.toString().padLeft(2, "0");
    final mm = m.toString().padLeft(2, "0");
    final ss = s.toString().padLeft(2, "0");
    return "$hh:$mm:$ss";
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Cap the base for tablet/desktop to avoid overflow
        final screenBase = min(constraints.maxWidth, constraints.maxHeight);
        final double base = min(screenBase, 400); // 400: adjust as needed
        final wheelSize = base * 0.62;
        final pointerSize = wheelSize * 0.09;
        final centerSize = wheelSize * 0.21;
        final buttonWidth = base * 0.64;

        return Center(
          child: Container(
            width: base,
            height: base * 1.17,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color(0xBB08162C),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF00CFFF),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                // Main content
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: base * 0.07),
                      Text(
                        "Daily Spin Wheel",
                        style: TextStyle(
                          fontSize: base * 0.09,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [Colors.amber, Colors.orange],
                            ).createShader(const Rect.fromLTWH(0, 0, 300, 100)),
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: base * 0.04),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer ring
                          Container(
                            width: wheelSize,
                            height: wheelSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFB8860B),
                                  Color(0xFFDAA520),
                                  Color(0xFFFFD700),
                                  Color(0xFFDAA520),
                                  Color(0xFFB8860B)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            padding: EdgeInsets.all(wheelSize * 0.045),
                            child: Transform.rotate(
                              angle: 0,
                              child: CustomPaint(
                                size: Size(wheelSize - wheelSize * 0.09,
                                    wheelSize - wheelSize * 0.09),
                                painter: SpinWheelPainter(
                                  colors: colors,
                                  labels: labels,
                                  rotation: rotation,
                                ),
                              ),
                            ),
                          ),
                          // Center Hub
                          Container(
                            width: centerSize,
                            height: centerSize,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [Colors.amber, Colors.orange],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                  color: const Color(0xFFB8860B), width: 3),
                            ),
                            child: Center(
                              child: Text(
                                "🪙",
                                style: TextStyle(
                                    fontSize: centerSize * 0.4,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF8B4513),
                                    shadows: const [
                                      Shadow(
                                          color: Colors.black45,
                                          offset: Offset(1, 1),
                                          blurRadius: 2)
                                    ]),
                              ),
                            ),
                          ),
                          // Pointer
                          Positioned(
                            top: -pointerSize / 2,
                            child: ClipPath(
                              clipper: TriangleClipper(),
                              child: Container(
                                width: pointerSize,
                                height: pointerSize,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: wheelSize * 0.09),

                      // Spin button
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: isSpinning ? null : _spin,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: wheelSize * 0.045),
                            backgroundColor: spinsLeft > 0
                                ? Colors.red
                                : const Color(0xBB08162C),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            shadowColor: Colors.black,
                            elevation: 10,
                          ),
                          child: Text(
                            spinsLeft > 0
                                ? "Spin ($spinsLeft left)"
                                : "No Spins Left",
                            style: TextStyle(
                                fontSize: wheelSize * 0.07,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),

                      SizedBox(height: wheelSize * 0.04),

                      // Countdown: show only when all spins are used
                      if (spinsLeft == 0 && remainingSeconds > 0)
                        Text(
                          "Next five spins in: ${_formatHMS(remainingSeconds)}",
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: wheelSize * 0.048,
                              fontWeight: FontWeight.bold),
                        ),
                      SizedBox(height: base * 0.03),
                    ],
                  ),
                ),
                // Cross button (top right inside container)
                Positioned(
                  top: base * 0.028,
                  right: base * 0.028,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: base * 0.11,
                      height: base * 0.11,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.20),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: base * 0.07,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SpinWheelPainter extends CustomPainter {
  final List<Color> colors;
  final List<String> labels;
  final double rotation;

  SpinWheelPainter({
    required this.colors,
    required this.labels,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final segmentAngle = 2 * pi / colors.length;
    final radius = size.width / 2;
    final center = Offset(radius, radius);

    // Apply rotation
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation * pi / 180);
    canvas.translate(-center.dx, -center.dy);

    // Draw each segment
    for (int i = 0; i < colors.length; i++) {
      final startAngle = i * segmentAngle;
      final sweepAngle = segmentAngle;

      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = colors[i];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw labels
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: Colors.white,
            fontSize: size.width * 0.07,
            fontWeight: FontWeight.bold,
            shadows: const [
              Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2)
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Position label
      final labelAngle = startAngle + segmentAngle / 2;
      final labelRadius = radius * 0.75;
      final labelOffset = Offset(
        center.dx + labelRadius * cos(labelAngle) - textPainter.width / 2,
        center.dy + labelRadius * sin(labelAngle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, labelOffset);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
