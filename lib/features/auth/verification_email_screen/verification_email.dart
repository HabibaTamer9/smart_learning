import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_learning/features/onboarding_screens/onboarding_screen.dart';

import '../login_screen/widgets/custom_button.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({super.key});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  User? user;

  bool isEmailVerified = false;

  bool isSending = false;

  DateTime? sendAt;

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    user = FirebaseAuth.instance.currentUser;
    isEmailVerified = user!.emailVerified;
    checkEmailVerified();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;
    setState(() {
      isEmailVerified = user?.emailVerified ?? false;
    });
    if (isEmailVerified && mounted) {
      timer!.cancel();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await user?.sendEmailVerification();
      setState(() {
        isSending = true;
        sendAt = DateTime.now();
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Verify Your Email",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
          Lottie.asset(
            'assets/lettiefile/VerifyYourEmail.json',
            fit: BoxFit.cover,
          ),
          CustomButton(
              text: "Resend Code",
              onPressed: () {
                sendEmailVerification();
              }),
        ],
      ),
    );
  }
}
