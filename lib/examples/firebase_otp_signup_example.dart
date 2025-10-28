// Example: How to update signuppage_widget.dart to use Firebase OTP
// Replace the existing signup button onPressed logic with this implementation

import '/services/firebase_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

// In your signup button's onPressed method:
FFButtonWidget(
  onPressed: () async {
    // Capture scaffold messenger before any async operations
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    // Validate form fields
    if (_model.textController1?.text == null || 
        _model.textController1!.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Please enter your name')),
      );
      return;
    }
    
    if (_model.textController2?.text == null || 
        _model.textController2!.text.isEmpty ||
        _model.textController2!.text.length != 10) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Please enter valid 10-digit phone number')),
      );
      return;
    }
    
    if (_model.textController3?.text == null || 
        _model.textController3!.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Please enter your email')),
      );
      return;
    }
    
    if (_model.textController4?.text == null || 
        _model.textController4!.text.isEmpty) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Please enter password')),
      );
      return;
    }
    
    if (_model.textController4?.text != _model.textController5?.text) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    
    if (_model.checkboxValue != true) {
      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Please agree to Terms and Privacy Policy')),
      );
      return;
    }

    // ============================================================
    // FIREBASE OTP IMPLEMENTATION
    // ============================================================
    
    // Step 1: Send OTP via Firebase
    bool otpSent = await FirebaseAuthService.sendOTP(
      phoneNumber: _model.textController2!.text,
      context: context,
      onCodeSent: (message) {
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      onError: (error) {
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(error),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
    );

    if (!otpSent) return;

    // Step 2: Show OTP dialog
    if (!mounted) return;
    
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return ConfirmOtpWidget(
          phoneNumber: _model.textController2!.text,
          onOtpVerified: () async {
            // This callback is called from the OTP dialog
            // after Firebase verifies the OTP successfully
            
            Navigator.pop(dialogContext); // Close dialog
            
            if (!mounted) return;
            
            scaffoldMessenger.showSnackBar(
              const SnackBar(
                content: Text('OTP verified successfully!'),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ),
            );

            // Step 3: Get Firebase ID token
            String? firebaseToken = await FirebaseAuthService.getIdToken();
            
            if (firebaseToken == null) {
              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('Failed to get authentication token'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              return;
            }

            // Step 4: Register user with backend
            try {
              _model.signup = await RegisterCall.call(
                name: _model.textController1?.text ?? '',
                phone: _model.textController2?.text ?? '',
                email: _model.textController3?.text ?? '',
                password: _model.textController4?.text ?? '',
                // Note: You may need to add firebaseToken parameter to RegisterCall
                // or send it in headers/body depending on your backend implementation
              );

              if (!mounted) return;

              if ((_model.signup?.succeeded ?? true)) {
                // Registration successful
                
                // Save the token from response
                String? token = getJsonField(
                  (_model.signup?.jsonBody ?? ''),
                  r'''$.token''',
                ).toString();
                
                if (token != null && token != 'null') {
                  FFAppState().update(() {
                    FFAppState().token = token;
                  });
                }
                
                // Step 5: Save device token
                try {
                  await DeviceTokenService.sendDeviceTokenToBackend();
                } catch (e) {
                  debugPrint('Device token error: $e');
                  // Continue even if device token fails
                }

                if (!mounted) return;

                scaffoldMessenger.showSnackBar(
                  const SnackBar(
                    content: Text('Registration successful!'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );

                // Navigate to home page (replace route stack)
                context.goNamed('homepage');
              } else {
                // Registration failed
                if (!mounted) return;
                
                String errorMessage = getJsonField(
                  (_model.signup?.jsonBody ?? ''),
                  r'''$.message''',
                ).toString();
                
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text(errorMessage.isEmpty ? 'Registration failed' : errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } catch (e) {
              if (mounted) {
                scaffoldMessenger.showSnackBar(
                  SnackBar(
                    content: Text('Registration error: ${e.toString()}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          onResendOtp: () async {
            // Resend OTP via Firebase
            await FirebaseAuthService.resendOTP(
              phoneNumber: _model.textController2!.text,
              context: dialogContext,
              onCodeSent: (message) {
                if (mounted) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              onError: (error) {
                if (mounted) {
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            );
          },
        );
      },
    );
  },
  text: 'Sign up',
  // ...existing button options...
)
