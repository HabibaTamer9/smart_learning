import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/features/auth/signup_screen/signup_cubit/signup_cubit.dart';
import 'package:smart_learning/features/auth/signup_screen/signup_cubit/signup_state.dart';
import 'package:smart_learning/features/auth/signup_screen/widgets/background_circle.dart';
import 'package:smart_learning/features/auth/signup_screen/widgets/custom_text.dart';
import 'package:smart_learning/features/auth/signup_screen/widgets/header.dart';
import 'package:smart_learning/features/main_screen.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/app_size.dart';
import '../login_screen/login.dart';
import '../../../core/widgets/custom_button.dart';
import '../login_screen/widgets/custom_text_field.dart';
import '../login_screen/widgets/social_login.dart';
import '../verification_email_screen/verification_email.dart';

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

  RegExp passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
  RegExp userRegExp =
      RegExp(r'^(?=.{8,20}$)(?![_.<])(?!.*[_.-]{2})[a-zA-Z0-9._]+(?<![_.;-])$');
  RegExp emailRegExp = RegExp(
      r"^^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  validationPassword(String? value) {
    if (value?.isEmpty ?? true) {
      return "Password is required";
    } else if (value!.length < 8) {
      return "Password must have at least 8 char";
    } else if (!passwordRegExp.hasMatch(value)) {
      return 'Password is not allowed';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(listener: (context, state) {
        if (state is SignupLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(child: CircularProgressIndicator()),
          );
        }
        if (state is SignupSuccess) {
          Navigator.pop(context); // close loading
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
        if (state is SignupEmailNotVerified) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => VerificationEmail()),
          );
        }
        if (state is SignupError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
              content: Text(
                state.errorMessage,
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
      }, builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
            height: AppSize.height,
            width: AppSize.width,
            child: Stack(
              children: [
                Positioned(left: -110, top: -90, child: BackgroundCircle()),
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 0,
                  top: AppSize.height * 0.09,
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
                                if (value?.isEmpty ?? true) {
                                  return "Username is required";
                                } else if (!userRegExp.hasMatch(value!)) {
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
                                if (value?.isEmpty ?? true) {
                                  return "Email is required";
                                } else if (!emailRegExp.hasMatch(value!)) {
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
                                      confirmPassIsHidden =
                                          !confirmPassIsHidden;
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
                                onPressed: () {
                                  if (keyForm.currentState!.validate()) {
                                    if (passwordController.text !=
                                        confirmPasswordC.text) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("Error"),
                                          content: Text(
                                            "Password and confirm password are not the same",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('OK'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      context.read<SignupCubit>().signup(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          username: usernameController.text);
                                    }
                                  }
                                },
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text(
                    "Login Now",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
