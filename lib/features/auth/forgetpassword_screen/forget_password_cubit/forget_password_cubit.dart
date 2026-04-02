import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/features/auth/forgetpassword_screen/forget_password_cubit/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> resetPassword({required String email}) async {
    emit(ForgetPasswordLoading());
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      String message = "";
      if (e.code == 'invalid-email') {
        message = "The email address is not valid.";
      } else if (e.code == 'too-many-requests') {
        message = "Too many requests. Please try again later.";
      } else {
        message = e.message ?? "Something went wrong.";
      }
      emit(ForgetPasswordError(message));
    } catch (e) {
      String message = "Unexpected error occurred.";
      emit(ForgetPasswordError(message));
    }
  }
}
