import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_learning/features/auth/verification_email_screen/verification_cubit/verification_cubit.dart';
import 'package:smart_learning/features/auth/verification_email_screen/verification_cubit/verification_state.dart';
import 'package:smart_learning/features/main_screen.dart';

import '../../../core/widgets/custom_button.dart';

class VerificationEmail extends StatefulWidget {
  const VerificationEmail({super.key});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {

  @override
  void dispose() {
    // TODO: implement dispose
    context.read<VerificationCubit>().disposeTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=>VerificationCubit()..verifyEmail(),
      child: BlocConsumer<VerificationCubit,VerificationState>(
        listener: (context, state) {
          if(state is VerificationEmailVerified){
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          }
        },
        builder: (context,state) {
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
                      context.read<VerificationCubit>().sendEmailVerification();
                    }),
              ],
            ),
          );
        }
      ),
    );
  }
}
