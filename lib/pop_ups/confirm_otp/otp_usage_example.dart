// Example of how to use the ConfirmOtpWidget in your Flutter app

import 'package:flutter/material.dart';
import '/pop_ups/confirm_otp/confirm_otp_widget.dart';

class OtpUsageExample {
  /// Shows the OTP popup as a dialog
  static void showOtpDialog(
    BuildContext context, {
    required String phoneNumber,
    required Function(String) onOtpVerified,
    Function()? onResendOtp,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ConfirmOtpWidget(
            phoneNumber: phoneNumber,
            onOtpVerified: (otp) {
              Navigator.pop(context); // Close the dialog
              onOtpVerified(otp);
            },
            onResendOtp: onResendOtp,
          ),
        );
      },
    );
  }

  /// Shows the OTP popup as a bottom sheet
  static void showOtpBottomSheet(
    BuildContext context, {
    required String phoneNumber,
    required Function(String) onOtpVerified,
    Function()? onResendOtp,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ConfirmOtpWidget(
            phoneNumber: phoneNumber,
            onOtpVerified: (otp) {
              Navigator.pop(context); // Close the bottom sheet
              onOtpVerified(otp);
            },
            onResendOtp: onResendOtp,
          ),
        );
      },
    );
  }

  /// Example usage in a signup flow
  static void exampleUsageInSignup(BuildContext context) {
    // Simulate sending OTP
    String phoneNumber = '+91 9876543210';

    // Show OTP dialog
    showOtpDialog(
      context,
      phoneNumber: phoneNumber,
      onOtpVerified: (otp) {
        // Handle successful OTP verification
        print('OTP Verified: $otp');

        // You can now:
        // 1. Call your verification API
        // 2. Navigate to next screen
        // 3. Complete the signup process

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('OTP verified successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onResendOtp: () {
        // Handle resend OTP
        print('Resending OTP to $phoneNumber');

        // Call your resend OTP API here
        // ResendOtpCall.call(phoneNumber: phoneNumber);
      },
    );
  }

  /// Integration example for existing signup button
  static Widget buildSignupButtonWithOtp(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // First, validate the form fields
        // Then show OTP popup
        String phoneNumber = '+91 9876543210'; // Get from form

        showOtpDialog(
          context,
          phoneNumber: phoneNumber,
          onOtpVerified: (otp) async {
            // Verify OTP with backend
            try {
              // final result = await VerifyOtpCall.call(
              //   phoneNumber: phoneNumber,
              //   otp: otp,
              // );

              // if (result.succeeded) {
              //   // Complete signup process
              //   // Navigate to home page
              //   context.pushNamed('HomePage');
              // }

              print('Signup completed with OTP: $otp');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OTP verification failed'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          onResendOtp: () {
            // Resend OTP logic
          },
        );
      },
      child: const Text('Sign Up'),
    );
  }
}
