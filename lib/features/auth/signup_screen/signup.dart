import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learning/features/auth/signup_screen/widgets/background_circle.dart';
import 'package:smart_learning/features/auth/signup_screen/widgets/custom_text.dart';
import 'package:smart_learning/features/auth/signup_screen/widgets/header.dart';

import '../../onboarding_screens/onboarding_screen.dart';
import '../login_screen/login.dart';
import '../login_screen/widgets/custom_button.dart';
import '../login_screen/widgets/custom_text_field.dart';
import '../login_screen/widgets/social_login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordC = TextEditingController();

  bool passIsHidden = true;
  bool confirmPassIsHidden = true;

  String errorMessage = '';

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  validationPassword(String? value) {
    RegExp regExp =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
    if (value?.isEmpty ?? true) {
      return "Password is required";
    } else if (value!.length < 8) {
      return "Password must have at least 8 char";
    } else if (!regExp.hasMatch(value)) {
      return 'Password is not allowed';
    }
    return null;
  }

  createUser() async {
    if (keyForm.currentState!.validate()) {
      if (passwordController.text != confirmPasswordC.text) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Error"),
            content: Text(
              "Password and confirm password are not the same",
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
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => Center(child: CircularProgressIndicator()),
        );
        try {
          final credential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          Navigator.pop(context); // close loading
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen()),
          );
        } on FirebaseAuthException catch (e) {
          Navigator.pop(context); // close loading

          String errorMessage = 'Erorr on create account';
          if (e.code == 'weak-password') {
            errorMessage = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            errorMessage = 'The account already exists for that email.';
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
        } catch (e) {
          errorMessage = e.toString();
        }
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
        child: Stack(
          children: [
            Positioned(left: -110, top: -90, child: BackgroundCircle()),
            Positioned(
              left: 20,
              right: 20,
              bottom: 0,
              top: MediaQuery.of(context).size.height * 0.09,
              child: SingleChildScrollView(
                child: Form(
                  key: keyForm,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Header(text: 'Hello! Signup to get started'),
                        CustomText(
                          text: "Username",
                        ),
                        CustomTextField(
                          hintText: 'Username',
                          validator: (value) {
                            RegExp regExp = RegExp(
                                r'^(?=.{8,20}$)(?![_.<])(?!.*[_.-]{2})[a-zA-Z0-9._]+(?<![_.;-])$');
                            if (value?.isEmpty ?? true) {
                              return "Username is required";
                            } else if (!regExp.hasMatch(value!)) {
                              return 'Username is not allowed';
                            }
                            return null;
                          },
                          controller: usernameController,
                        ),
                        CustomText(text: "Email"),
                        CustomTextField(
                          hintText: 'Email',
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
                        CustomText(text: "Password"),
                        CustomTextField(
                          hintText: 'Password',
                          isObscureText: passIsHidden,
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passIsHidden = !passIsHidden;
                                });
                              },
                              icon: passIsHidden
                                  ? Icon(Icons.visibility,
                                      color: Colors.grey.shade600)
                                  : Icon(Icons.visibility_off,
                                      color: Colors.grey.shade600)),
                          validator: (value) => validationPassword(value),
                          controller: passwordController,
                        ),
                        CustomText(text: "Confirm Password"),
                        CustomTextField(
                          hintText: 'Confirm Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  confirmPassIsHidden = !confirmPassIsHidden;
                                });
                              },
                              icon: confirmPassIsHidden
                                  ? Icon(Icons.visibility,
                                      color: Colors.grey.shade600)
                                  : Icon(Icons.visibility_off,
                                      color: Colors.grey.shade600)),
                          validator: (value) => validationPassword(value),
                          controller: confirmPasswordC,
                          isObscureText: confirmPassIsHidden,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CustomButton(
                            text: 'Sign up',
                            onPressed: () => createUser(),
                          ),
                        ),
                        SocialLogin(),
                      ]),
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
            "Already have an account?",
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
                "Login Now",
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
