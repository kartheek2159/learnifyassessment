// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learnifyassessment/screens/login.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final myModel = Provider.of<MyModel>(context, listen: false);
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String phoneCode = arguments?['phoneCode'] as String? ?? '';
    final String phoneNumber = arguments?['phoneNumber'] as String? ?? '';
    // Access the 'textshow' argument (string)
    var code = "";
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back)),
              ],
            ),
            const Text(
              "OTP Verify",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/pic1.jpg',
              width: 300,
              height: 300,
            ),
            // const SizedBox(
            //   height: 75,
            // ),
            Column(
              children: [
                const Text(
                  "OTP Sent to",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  " ${"+"} ${phoneCode} ${phoneNumber}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Pinput(
              length: 6,
              showCursor: true,
              onChanged: (value) {
                myModel.updateCode(value);
              },
              defaultPinTheme: PinTheme(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.grey,
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: InkWell(
                onTap: () async {
                  // Create a PhoneAuthCredential with the code
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: Login.verify,
                            smsCode: myModel.code);

                    // Sign the user in (or link) with the credential
                    await auth.signInWithCredential(credential);
                    Navigator.pushNamed(
                      context,
                      '/loginscreen',
                    );
                    showDialog(
                      context:
                          context, // Replace 'context' with your current BuildContext
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Verification Successful"),
                          content: const Text("Your details has Submittted."),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } catch (e) {
                    showDialog(
                      context:
                          context, // Replace 'context' with your current BuildContext
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Verification Failed!!"),
                          content: const Text("Wrong or Invalid OTP"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: const Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Container(
                  height: 58,
                  width: 8.9 * MediaQuery.of(context).size.width / 10,
                  decoration: BoxDecoration(
                    color: Colors.red.shade400,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                  child: const Center(
                    child: Text(
                      "Verify  OTP",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 58,
              width: 8.9 * MediaQuery.of(context).size.width / 10,
              // color: Colors.amber,
              child: const Center(
                child: Text(
                  "By signing up you agree with our Terms and Conditions",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
