import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = '+91';
  String _verificationId = '';
  String _smsCode = '';
  bool _isCodeSent = false;

  // Method to verify phone number
  void _verifyPhoneNumber() async {
    await _auth.verifyPhoneNumber(
      phoneNumber: _phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Automatically sign in the user on certain devices
        await _auth.signInWithCredential(credential);
        if (kDebugMode) {
          print(
            'Phone number automatically verified and user signed in: $credential');
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        if (kDebugMode) {
          print(
            'Phone number verification failed. Code: ${e.code}. Message: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        // Save the verification ID and show the OTP input field
        setState(() {
          _verificationId = verificationId;
          _isCodeSent = true;
        });
        if (kDebugMode) {
          print('Code sent to $_phoneNumber');
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
        if (kDebugMode) {
          print('Auto retrieval time out');
        }
      },
    );
  }

  // Method to sign in with the OTP code
  void _signInWithPhoneNumber() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: _smsCode,
      );

      // Sign the user in (or link) with the credential
      await _auth.signInWithCredential(credential);
      if (kDebugMode) {
        print('Successfully signed in with phone number: $_phoneNumber');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to sign in: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) {
                setState(() {
                  _phoneNumber = "+91$value";
                });
              },
            ),
            if (_isCodeSent)
              TextField(
                decoration: const InputDecoration(labelText: 'OTP Code'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _smsCode = value;
                  });
                },
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed:
                  _isCodeSent ? _signInWithPhoneNumber : _verifyPhoneNumber,
              child: Text(_isCodeSent ? 'Sign In' : 'Verify Phone Number'),
            ),
          ],
        ),
      ),
    );
  }
}
