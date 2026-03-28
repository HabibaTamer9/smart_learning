import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/features/auth/login_screen/widgets/custom_button.dart';
import 'package:smart_learning/features/auth/login_screen/widgets/custom_text_field.dart';
import 'package:smart_learning/features/auth/login_screen/widgets/social_login.dart';
import 'package:smart_learning/features/home_screen/home_screen.dart';

import '../../onboarding_screens/onboarding_screen.dart';
import '../forgetpassword_screen/forget_password.dart';
import '../signup_screen/signup.dart';
import '../signup_screen/widgets/background_circle.dart';
import '../signup_screen/widgets/custom_text.dart';
import '../signup_screen/widgets/header.dart';
import '../verification_email_screen/verification_email.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isHidden = true;

  loginValidation() async {
    if (keyForm.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(child: CircularProgressIndicator()),
      );
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        User? user = credential.user;
        if(user != null){
          if(user.emailVerified) {
            Navigator.pop(context); // close loading
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }else{
            await user.sendEmailVerification();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> VerificationEmail()));
          }
        }

      } on FirebaseAuthException catch (e) {
        Navigator.pop(context); // close loading

        String errorMessage = 'Wrong Username or Password';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
          setState(() {});
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
          setState(() {});
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(
              errorMessage,
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
      }
    }
  }
  validationPassword(String? value) {
    RegExp regExp =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    if (value?.isEmpty ?? true) {
      return "Password is required";
    } else if (value!.length < 8) {
      return "Password must have at least 8 char";
     }
    // else if (!regExp.hasMatch(value)) {
    //   return 'Password is not allowed';
    // }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
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
                      Header(text: 'Hi, Welcome!👋'),
                      CustomText(text: "Email"),
                      CustomTextField(
                        hintText: 'Enter Your email',
                        validator: (value) {
                          RegExp regExp = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
                          if (value?.isEmpty ?? true) {
                            return "Email is required";
                          } else if (!regExp.hasMatch(value!)) {
                            return 'Email is not allowed';
                          }
                          return null;
                        },
                        controller: emailController,
                      ),
                      CustomText(text: "Password"),
                      CustomTextField(
                        hintText: 'Enter Your password',
                        isObscureText: isHidden,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            icon: isHidden
                                ? Icon(Icons.visibility,
                                    color: Colors.grey.shade600)
                                : Icon(Icons.visibility_off,
                                    color: Colors.grey.shade600)),
                        validator: (value) => validationPassword(value),
                        controller: passwordController,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (val) {}),
                                Text(
                                  "Remember me",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPassword()));
                                },
                                child: Text(
                                  'Forget Password?',
                                  style: TextStyle(
                                      color: Color(0xff6A707C), fontSize: 15),
                                )),
                          ]),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                        child: CustomButton(
                          text: 'Login',
                          onPressed: () => loginValidation(),
                        ),
                      ),
                      SocialLogin(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account?",
            style: TextStyle(
                color: Color(0xff6A707C),
                fontSize: 17,
                fontWeight: FontWeight.w500),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text(
                "Sign up",
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
