import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String? _verificationId;
  static int? _resendToken;

  /// Send OTP to phone number using Firebase Authentication
  /// Returns true if OTP sent successfully
  static Future<bool> sendOTP({
    required String phoneNumber,
    required BuildContext context,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    try {
      // Ensure phone number has country code
      String formattedPhone =
          phoneNumber.startsWith('+') ? phoneNumber : '+91$phoneNumber';

      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: const Duration(seconds: 60),

        // Called when verification is completed automatically (instant verification)
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-verification (rare on Android, common on iOS)
          await _auth.signInWithCredential(credential);
          onCodeSent('Auto-verified');
        },

        // Called when verification fails
        verificationFailed: (FirebaseAuthException e) {
          String errorMessage = 'Failed to send OTP';
          if (e.code == 'invalid-phone-number') {
            errorMessage = 'Invalid phone number';
          } else if (e.code == 'too-many-requests') {
            errorMessage = 'Too many requests. Try again later';
          } else if (e.code == 'quota-exceeded') {
            errorMessage = 'SMS quota exceeded';
          }
          onError(errorMessage);
        },

        // Called when OTP is sent successfully
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _resendToken = resendToken;
          onCodeSent('OTP sent successfully');
        },

        // Called when auto-retrieval timeout
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },

        // Use stored resend token for resend OTP
        forceResendingToken: _resendToken,
      );

      return true;
    } catch (e) {
      onError('Error sending OTP: ${e.toString()}');
      return false;
    }
  }

  /// Verify OTP code entered by user
  /// Returns UserCredential if successful, null otherwise
  static Future<UserCredential?> verifyOTP({
    required String otpCode,
    required Function(String) onError,
  }) async {
    try {
      if (_verificationId == null) {
        onError('Verification ID not found. Please resend OTP');
        return null;
      }

      // Create credential with verification ID and OTP code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpCode,
      );

      // Sign in with credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Invalid OTP';
      if (e.code == 'invalid-verification-code') {
        errorMessage = 'Invalid OTP code';
      } else if (e.code == 'session-expired') {
        errorMessage = 'OTP expired. Please resend';
      }
      onError(errorMessage);
      return null;
    } catch (e) {
      onError('Error verifying OTP: ${e.toString()}');
      return null;
    }
  }

  /// Get current Firebase user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Get Firebase ID token for backend authentication
  static Future<String?> getIdToken() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return await user.getIdToken();
      }
      return null;
    } catch (e) {
      debugPrint('Error getting ID token: $e');
      return null;
    }
  }

  /// Sign out current user
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Resend OTP
  static Future<bool> resendOTP({
    required String phoneNumber,
    required BuildContext context,
    required Function(String) onCodeSent,
    required Function(String) onError,
  }) async {
    return await sendOTP(
      phoneNumber: phoneNumber,
      context: context,
      onCodeSent: onCodeSent,
      onError: onError,
    );
  }
}
