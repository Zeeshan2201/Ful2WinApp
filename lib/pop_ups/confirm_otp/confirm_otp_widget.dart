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
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: controller.text.isNotEmpty
              ? const Color(0xFFF7B500)
              : const Color(0xFF475569),
          width: 2,
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        autofocus: false,
        textAlign: TextAlign.center,
        obscureText: false,
        decoration: InputDecoration(
          isDense: true,
          labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.inter(),
                letterSpacing: 0.0,
              ),
          hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.inter(),
                letterSpacing: 0.0,
              ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          // Remove contentPadding so text is perfectly centered
        ),
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(
                fontSize: boxSize * 0.42, // Responsive font size
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
    // Calculate responsive box size based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth =
        (screenWidth * 0.9).clamp(280.0, 400.0); // Dialog width with limits
    final availableWidth = dialogWidth - 70; // Subtract padding (20+20+15+15)
    final boxSize = (availableWidth / 7)
        .clamp(35.0, 48.0); // 6 boxes + spacing, min 35, max 48

    return Container(
      width: dialogWidth,
      constraints: BoxConstraints(
        maxWidth: 400,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
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
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Verify OTP',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                          ),
                          color: Colors.white,
                          fontSize: 24,
                          letterSpacing: 0.0,
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
              const SizedBox(height: 20),

              // Description
              Text(
                'We\'ve sent a 6-digit verification code to',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(),
                      color: const Color(0xFFE2E8F0),
                      letterSpacing: 0.0,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),

              // Phone number
              Text(
                widget.phoneNumber ?? '+91 ***** *****',
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                      ),
                      color: const Color(0xFFF7B500),
                      letterSpacing: 0.0,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // OTP Input Fields
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildOtpInputField(
                      controller: _model.otpDigit1TextController!,
                      focusNode: _model.otpDigit1FocusNode!,
                      nextFocusNode: _model.otpDigit2FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    _buildOtpInputField(
                      controller: _model.otpDigit2TextController!,
                      focusNode: _model.otpDigit2FocusNode!,
                      nextFocusNode: _model.otpDigit3FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    _buildOtpInputField(
                      controller: _model.otpDigit3TextController!,
                      focusNode: _model.otpDigit3FocusNode!,
                      nextFocusNode: _model.otpDigit4FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    _buildOtpInputField(
                      controller: _model.otpDigit4TextController!,
                      focusNode: _model.otpDigit4FocusNode!,
                      nextFocusNode: _model.otpDigit5FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
                    _buildOtpInputField(
                      controller: _model.otpDigit5TextController!,
                      focusNode: _model.otpDigit5FocusNode!,
                      nextFocusNode: _model.otpDigit6FocusNode,
                      isLast: false,
                      boxSize: boxSize,
                    ),
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
              const SizedBox(height: 30),

              // Verify Button
              FFButtonWidget(
                onPressed: _verifyOtp,
                text: 'Verify OTP',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 50,
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: const Color(0xFFF7B500),
                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                        ),
                        color: const Color(0xFF1E293B),
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
              const SizedBox(height: 20),

              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive code? ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.inter(),
                          color: const Color(0xFFE2E8F0),
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
