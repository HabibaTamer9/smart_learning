import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/widgets/custom_button.dart';
import 'package:smart_learning/features/auth/login_screen/login_cubit/login_cubit.dart';
import 'package:smart_learning/features/auth/login_screen/login_cubit/state.dart';
import 'package:smart_learning/features/auth/login_screen/widgets/custom_text_field.dart';
import 'package:smart_learning/features/auth/login_screen/widgets/social_login.dart';
import 'package:smart_learning/features/main_screen.dart';

import '../../../core/const/app_size.dart';
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

  RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  RegExp passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
  bool isHidden = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => Center(child: CircularProgressIndicator()),
          );
        }
        if (state is LoginSuccess) {
          Navigator.pop(context); // close loading
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
        if (state is LoginEmailNotVerified) {
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => VerificationEmail()),
          );
        }
        if (state is LoginError) {
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
                  top: AppSize.height * 0.2,
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
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Password is required";
                              } else if (value!.length < 8) {
                                return "Password must have at least 8 char";
                              }
                              // else if (!passwordRegExp.hasMatch(value)) {
                              //   return 'Password is not allowed';
                              // }
                              return null;
                            },
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ForgetPassword()));
                                    },
                                    child: Text(
                                      'Forget Password?',
                                      style: TextStyle(
                                          color: Color(0xff6A707C),
                                          fontSize: 15),
                                    )),
                              ]),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 20),
                            child: CustomButton(
                              text: 'Login',
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  context.read<LoginCubit>().login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                }
                              },
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
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    "Sign up",
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
