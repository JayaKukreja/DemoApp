import 'package:demo_app_bds/View/email_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAnimationScreen extends StatelessWidget {
  const RiveAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rive Animation'),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return EmailInputScreen();
              }));
            },
            child: const Text(
              "Go to next screen",
              style: TextStyle(fontSize: 32),
            ),
          ),
          const Expanded(
            child: Center(
              child: RiveAnimation.network(
                'https://cdn.rive.app/animations/vehicles.riv',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
