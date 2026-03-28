import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_screen/login.dart';
import '../login_screen/widgets/custom_button.dart';
import '../login_screen/widgets/custom_text_field.dart';
import '../signup_screen/widgets/background_circle.dart';
import '../signup_screen/widgets/custom_text.dart';
import '../signup_screen/widgets/header.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  resetPassword(String email) async {
    if (keyForm.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator()),
      );
      String message = "";
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Password reset email sent successfully.Please check your email."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          message = "The email address is not valid.";
        } else if (e.code == 'too-many-requests') {
          message = "Too many requests. Please try again later.";
        } else {
          message = e.message ?? "Something went wrong.";
        }
        setState(() {

        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(
              message,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        message = "Unexpected error occurred.";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(children: [
            Positioned(left: -110, top: -90, child: BackgroundCircle()),
            Positioned(
                left: 20,
                right: 20,
                bottom: 0,
                top: MediaQuery.of(context).size.height * 0.2,
                child: SingleChildScrollView(
                  child: Form(
                    key: keyForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(text: "Forget Password"),
                        Text(
                          "Don’t worry! It happens. Please enter the email associated with your account.",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        CustomText(text: "Email Address"),
                        CustomTextField(
                          hintText: 'Enter Your Email Address',
                          validator: (value) {
                            RegExp regExp = RegExp(
                                r"^^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                            if (value?.isEmpty ?? true) {
                              return "Email is required";
                            } else if (!regExp.hasMatch(value!)) {
                              return 'Email is not allowed';
                            }
                            return null;
                          },
                          controller: emailController,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomButton(text: "Send Code", onPressed: () {resetPassword(emailController.text);}),
                      ],
                    ),
                  ),
                ))
          ])),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Remember Password?",
            style: TextStyle(
                color: Color(0xff6A707C),
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
