import 'package:demo_app_bds/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailInputScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  EmailInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text;
                await DatabaseHelper().insertEmail(email);
                Fluttertoast.showToast(
                    gravity: ToastGravity.CENTER,
                    fontSize: 24,
                    msg:
                        "Email saved.You can reopen the app to check stored email ID");
              },
              child: const Text('Save Email'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     await FirebaseAuth.instance.signOut();
            //     Navigator.of(context)
            //         .push(MaterialPageRoute(builder: (context) {
            //       return const PhoneAuthScreen();
            //     }));
            //   },
            //   child: const Text('Sign Out'),
            // ),
          ],
        ),
      ),
    );
  }
}
