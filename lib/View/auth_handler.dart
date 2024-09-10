import 'package:demo_app_bds/View/phone_auth_screen.dart';
import 'package:demo_app_bds/View/rive_animation_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          return user == null
              ? const PhoneAuthScreen()
              : const RiveAnimationScreen();
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
