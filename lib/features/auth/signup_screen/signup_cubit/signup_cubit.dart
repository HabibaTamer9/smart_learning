import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/features/auth/signup_screen/signup_cubit/signup_state.dart';

import '../../../../core/data.dart';
import '../../model/user_model.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  Future<void> signup(
      {required String email, required String password, required String username}) async {
    emit(SignupLoading());
    var db = FirebaseFirestore.instance;
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;

      if (user != null) {
        var uid = user.uid;
        Map<String, dynamic> newUser = {
          "uid": uid,
          "username": username,
          "email": email,
          "profileImageUrl": "",
          "score": 0,
          "track": "",
          "level": "",
        };
        try {
          db.collection("users").doc(uid).set(newUser).then((
              _) {
            print('User added with UID as docId');
          });
        }on FirebaseException catch (e) {
          emit(SignupError(e.toString()));
        }catch(e){
          emit(SignupError(e.toString()));
        }
        var getUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        Data.user = UserModel.fromJson(getUser.data()!);
        if (user.emailVerified) {
          emit(SignupSuccess());
        } else {
          emit(SignupEmailNotVerified());
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Error on create account';
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }
      emit(SignupError(errorMessage));
    } catch (e) {
      String errorMessage = e.toString();
      emit(SignupError(errorMessage));
    }
  }
}