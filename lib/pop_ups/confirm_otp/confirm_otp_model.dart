import '/flutter_flow/flutter_flow_util.dart';
import 'confirm_otp_widget.dart' show ConfirmOtpWidget;
import 'package:flutter/material.dart';

class ConfirmOtpModel extends FlutterFlowModel<ConfirmOtpWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for OTP input fields
  FocusNode? otpDigit1FocusNode;
  TextEditingController? otpDigit1TextController;
  String? Function(BuildContext, String?)? otpDigit1TextControllerValidator;

  FocusNode? otpDigit2FocusNode;
  TextEditingController? otpDigit2TextController;
  String? Function(BuildContext, String?)? otpDigit2TextControllerValidator;

  FocusNode? otpDigit3FocusNode;
  TextEditingController? otpDigit3TextController;
  String? Function(BuildContext, String?)? otpDigit3TextControllerValidator;

  FocusNode? otpDigit4FocusNode;
  TextEditingController? otpDigit4TextController;
  String? Function(BuildContext, String?)? otpDigit4TextControllerValidator;

  FocusNode? otpDigit5FocusNode;
  TextEditingController? otpDigit5TextController;
  String? Function(BuildContext, String?)? otpDigit5TextControllerValidator;

  FocusNode? otpDigit6FocusNode;
  TextEditingController? otpDigit6TextController;
  String? Function(BuildContext, String?)? otpDigit6TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    otpDigit1FocusNode?.dispose();
    otpDigit1TextController?.dispose();

    otpDigit2FocusNode?.dispose();
    otpDigit2TextController?.dispose();

    otpDigit3FocusNode?.dispose();
    otpDigit3TextController?.dispose();

    otpDigit4FocusNode?.dispose();
    otpDigit4TextController?.dispose();

    otpDigit5FocusNode?.dispose();
    otpDigit5TextController?.dispose();

    otpDigit6FocusNode?.dispose();
    otpDigit6TextController?.dispose();
  }

  /// Gets the complete OTP as a string
  String getOtp() {
    return (otpDigit1TextController?.text ?? '') +
        (otpDigit2TextController?.text ?? '') +
        (otpDigit3TextController?.text ?? '') +
        (otpDigit4TextController?.text ?? '') +
        (otpDigit5TextController?.text ?? '') +
        (otpDigit6TextController?.text ?? '');
  }

  /// Clears all OTP input fields
  void clearOtp() {
    otpDigit1TextController?.clear();
    otpDigit2TextController?.clear();
    otpDigit3TextController?.clear();
    otpDigit4TextController?.clear();
    otpDigit5TextController?.clear();
    otpDigit6TextController?.clear();
  }

  /// Validates if OTP is complete (6 digits)
  bool isOtpComplete() {
    return getOtp().length == 6;
  }
}
