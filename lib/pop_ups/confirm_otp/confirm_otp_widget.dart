import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confirm_otp_model.dart';
export 'confirm_otp_model.dart';

class ConfirmOtpWidget extends StatefulWidget {
  const ConfirmOtpWidget({
    super.key,
    this.phoneNumber,
    this.onOtpVerified,
    this.onResendOtp,
  });

  final String? phoneNumber;
  final Function(String)? onOtpVerified;
  final Function()? onResendOtp;

  @override
  State<ConfirmOtpWidget> createState() => _ConfirmOtpWidgetState();
}

class _ConfirmOtpWidgetState extends State<ConfirmOtpWidget> {
  late ConfirmOtpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfirmOtpModel());

    _model.otpDigit1TextController ??= TextEditingController();
    _model.otpDigit1FocusNode ??= FocusNode();

    _model.otpDigit2TextController ??= TextEditingController();
    _model.otpDigit2FocusNode ??= FocusNode();

    _model.otpDigit3TextController ??= TextEditingController();
    _model.otpDigit3FocusNode ??= FocusNode();

    _model.otpDigit4TextController ??= TextEditingController();
    _model.otpDigit4FocusNode ??= FocusNode();

    _model.otpDigit5TextController ??= TextEditingController();
    _model.otpDigit5FocusNode ??= FocusNode();

    _model.otpDigit6TextController ??= TextEditingController();
    _model.otpDigit6FocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  Widget _buildOtpInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required FocusNode? nextFocusNode,
    required bool isLast,
    required double boxSize,
  }) {
    return Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: controller.text.isNotEmpty
              ? const Color(0xFFF7B500)
              : const Color(0xFF475569),
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        obscureText: false,
        decoration: const InputDecoration(
          isDense: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(
                fontSize: boxSize * 0.5, // Larger font for better visibility
                fontWeight: FontWeight.w600,
              ),
              color: Colors.white,
              letterSpacing: 0.0,
            ),
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        onChanged: (value) {
          if (value.length == 1 && !isLast && nextFocusNode != null) {
            nextFocusNode.requestFocus();
          } else if (value.isEmpty && focusNode.hasFocus) {
            // Handle backspace to previous field
            _moveToPreviousField(focusNode);
          }
          setState(() {});
        },
      ),
    );
  }

  void _moveToPreviousField(FocusNode currentFocusNode) {
    if (currentFocusNode == _model.otpDigit2FocusNode) {
      _model.otpDigit1FocusNode?.requestFocus();
    } else if (currentFocusNode == _model.otpDigit3FocusNode) {
      _model.otpDigit2FocusNode?.requestFocus();
    } else if (currentFocusNode == _model.otpDigit4FocusNode) {
      _model.otpDigit3FocusNode?.requestFocus();
    } else if (currentFocusNode == _model.otpDigit5FocusNode) {
      _model.otpDigit4FocusNode?.requestFocus();
    } else if (currentFocusNode == _model.otpDigit6FocusNode) {
      _model.otpDigit5FocusNode?.requestFocus();
    }
  }

  void _verifyOtp() {
    if (_model.isOtpComplete()) {
      final otp = _model.getOtp();
      widget.onOtpVerified?.call(otp);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter all 6 digits of OTP'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive calculations
    final isSmallScreen = screenWidth < 360;
    final isMediumScreen = screenWidth >= 360 && screenWidth < 400;

    // Dialog width - responsive to screen size
    final dialogWidth = (screenWidth * 0.9).clamp(300.0, 450.0);

    // Padding responsive to screen size
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenHeight * 0.02; // 2% of screen height

    // OTP box calculations - more conservative
    final otpRowPadding = horizontalPadding.clamp(5.0, 15.0);
    final availableWidth =
        dialogWidth - (horizontalPadding * 2) - (otpRowPadding * 2);
    final spacing = isSmallScreen ? 3.0 : (isMediumScreen ? 4.0 : 5.0);
    // Calculate box size to fit 6 boxes + 5 spacings
    final totalSpacing = spacing * 5 + 30;
    final boxSize = ((availableWidth - totalSpacing) / 6).clamp(35.0, 52.0);

    // Font sizes
    final titleFontSize = isSmallScreen ? 20.0 : (isMediumScreen ? 22.0 : 24.0);
    final bodyFontSize = isSmallScreen ? 13.0 : (isMediumScreen ? 14.0 : 15.0);
    final phoneFontSize = isSmallScreen ? 15.0 : (isMediumScreen ? 16.0 : 17.0);

    // Spacing
    final headerSpacing = screenHeight * 0.02;
    final sectionSpacing = screenHeight * 0.025;

    return Container(
      width: dialogWidth,
      constraints: BoxConstraints(
        maxWidth: 450,
        maxHeight: screenHeight * 0.85,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0A2A66), Color(0xFF0033CC)],
          stops: [0.5, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding.clamp(15.0, 25.0),
            vertical: verticalPadding.clamp(15.0, 25.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Verify OTP',
                      style:
                          FlutterFlowTheme.of(context).headlineSmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                ),
                                color: Colors.white,
                                fontSize: titleFontSize,
                                letterSpacing: 0.0,
                              ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderRadius: 20,
                    buttonSize: 40,
                    fillColor: const Color(0x33FFFFFF),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: headerSpacing.clamp(15.0, 20.0)),

              // Description
              Text(
                'We\'ve sent a 6-digit verification code to',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: const Color(0xFFE2E8F0),
                      fontSize: bodyFontSize,
                      letterSpacing: 0.0,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: headerSpacing * 0.4),

              // Phone number
              Text(
                widget.phoneNumber ?? '+91 ***** *****',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                      color: const Color(0xFFF7B500),
                      fontSize: phoneFontSize,
                      letterSpacing: 0.0,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sectionSpacing.clamp(20.0, 30.0)),

              // OTP Input Fields
              Padding(
                padding: EdgeInsets.symmetric(horizontal: otpRowPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOtpInputField(
                      controller: _model.otpDigit1TextController!,
                      focusNode: _model.otpDigit1FocusNode!,
                      nextFocusNode: _model.otpDigit2FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    SizedBox(width: spacing),
                    _buildOtpInputField(
                      controller: _model.otpDigit2TextController!,
                      focusNode: _model.otpDigit2FocusNode!,
                      nextFocusNode: _model.otpDigit3FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    SizedBox(width: spacing),
                    _buildOtpInputField(
                      controller: _model.otpDigit3TextController!,
                      focusNode: _model.otpDigit3FocusNode!,
                      nextFocusNode: _model.otpDigit4FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    SizedBox(width: spacing),
                    _buildOtpInputField(
                      controller: _model.otpDigit4TextController!,
                      focusNode: _model.otpDigit4FocusNode!,
                      nextFocusNode: _model.otpDigit5FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    SizedBox(width: spacing),
                    _buildOtpInputField(
                      controller: _model.otpDigit5TextController!,
                      focusNode: _model.otpDigit5FocusNode!,
                      nextFocusNode: _model.otpDigit6FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    SizedBox(width: spacing),
                    _buildOtpInputField(
                      controller: _model.otpDigit6TextController!,
                      focusNode: _model.otpDigit6FocusNode!,
                      nextFocusNode: null,
                      isLast: true,
                      boxSize: boxSize,
                    ),
                  ],
                ),
              ),
              SizedBox(height: sectionSpacing.clamp(20.0, 30.0)),

              // Verify Button
              FFButtonWidget(
                onPressed: _verifyOtp,
                text: 'Verify OTP',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: isSmallScreen ? 45 : 50,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: const Color(0xFFF7B500),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                        color: const Color(0xFF1E293B),
                        fontSize: isSmallScreen ? 15.0 : 16.0,
                        letterSpacing: 0.0,
                      ),
                  elevation: 3,
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  disabledColor: const Color(0xFF6B7280),
                ),
              ),
              SizedBox(height: headerSpacing.clamp(15.0, 20.0)),

              // Resend OTP
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive code? ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(),
                          color: const Color(0xFFE2E8F0),
                          fontSize: bodyFontSize,
                          letterSpacing: 0.0,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      _model.clearOtp();
                      widget.onResendOtp?.call();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('OTP sent successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Text(
                      'Resend OTP',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                            ),
                            color: const Color(0xFFF7B500),
                            fontSize: bodyFontSize,
                            letterSpacing: 0.0,
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
