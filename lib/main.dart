import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnifyassessment/screens/login.dart';
import 'package:learnifyassessment/screens/otp.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyModel with ChangeNotifier {
  String code = "";

  void updateCode(String newCode) {
    code = newCode;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          '/otpscreen': (context) => const Otp(),
          '/loginscreen': (context) => const Login(),
        },
        home: const Login(),
      ),
    );
  }
}
