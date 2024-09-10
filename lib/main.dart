import 'package:demo_app_bds/View/auth_handler.dart';
import 'package:demo_app_bds/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _showEmailOnReopen();
  }

  Future<void> _showEmailOnReopen() async {
    String? email = await DatabaseHelper().getEmail();
    if (kDebugMode) {
      print("email===$email");
    }
    if (email != null) {
      Fluttertoast.showToast(
        msg: 'Welcome back! Email: $email',
        backgroundColor: Colors.white,
        fontSize: 20,
        textColor: Colors.black,
        gravity: ToastGravity.CENTER,
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (kDebugMode) {
        print("resumed");
      }
      _showEmailOnReopen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'BDS Demo',
      home: AuthHandler(),
    );
  }
}
