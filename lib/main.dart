import 'package:flutter/material.dart';
import 'package:learnifyassessment/screens/login.dart';
import 'package:learnifyassessment/screens/otp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/otpscreen': (context) => const Otp(),
        '/loginscreen': (context) => const Login(),
      },
      home: const Login(),
    );
  }
}
