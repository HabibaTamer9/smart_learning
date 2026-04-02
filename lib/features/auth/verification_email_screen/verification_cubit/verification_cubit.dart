import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/features/auth/verification_email_screen/verification_cubit/verification_state.dart';

class VerificationCubit extends Cubit<VerificationState>{
  VerificationCubit() : super(VerificationInitial());

  User? user;

  DateTime? sendAt;

  Timer? timer;

  Future<void> verifyEmail() async {
    emit(VerificationLoading());
    user = FirebaseAuth.instance.currentUser;
    sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  Future<void> checkEmailVerified() async {
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;
    if (user!.emailVerified) {
      timer!.cancel();
      emit(VerificationEmailVerified());
    }else{
      emit(VerificationEmailNotVerified());
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      await user?.sendEmailVerification();
        emit(VerificationEmailSent());
        sendAt = DateTime.now();
    } catch (e) {
      emit(VerificationError(e.toString()));
    }
  }
  void disposeTimer() {
    timer?.cancel();
  }
}