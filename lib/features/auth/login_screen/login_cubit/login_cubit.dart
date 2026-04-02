import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/features/auth/login_screen/login_cubit/state.dart';

import '../../../../core/data.dart';
import '../../model/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? users = credential.user;
      if (users != null) {
        var uid = users.uid;
        var getUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        Data.user = UserModel.fromJson(getUser.data()!);

        if (users.emailVerified) {
          emit(LoginSuccess());
        } else {
          emit(LoginEmailNotVerified());
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Wrong Username or Password';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      emit(LoginError(errorMessage));
    }
  }
}
