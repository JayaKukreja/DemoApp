import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _phoneNumber = '';
  String _verificationId = '';
  String _otp = '';

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Auth'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Phone Number'),
              onChanged: (value) {
                _phoneNumber = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await _auth.verifyPhoneNumber(
                  phoneNumber: _phoneNumber,
                  verificationCompleted: (PhoneAuthCredential credential) async {
                    await _auth.signInWithCredential(credential);
                  },
                  verificationFailed: (FirebaseAuthException e) {
                    print('Failed: ${e.message}');
                  },
                  codeSent: (String verificationId, int? resendToken) {
                    setState(() {
                      _verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (String verificationId) {},
                );
              },
              child: const Text('Verify'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Enter OTP'),
              onChanged: (value) {
                _otp = value;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: _verificationId,
                  smsCode: _otp,
                );
                await _auth.signInWithCredential(credential);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


