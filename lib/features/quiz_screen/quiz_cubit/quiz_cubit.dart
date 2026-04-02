import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_learning/features/auth/model/user_model.dart';
import 'package:smart_learning/features/quiz_screen/quiz_cubit/quiz_state.dart';
import 'package:smart_learning/features/track_screen/services/track_model.dart';

import '../../../core/data.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());

  int score = 0;


  void nextQuestion(int selectedAnswer, TrackModel track , int index) {
    var questions = track.question;
    if (selectedAnswer == questions[index].correctIndex) {
      score++;
    }
    if (index < questions.length - 1) {
      emit(QuizNextQuestion(index + 1));
    } else {
      finishQuiz(Data.user.uid,track.id );
    }
  }

  void finishQuiz(String uid , String trackId) async {
    String level = "";

    if (score <= 4) {
      level = "Beginner";
    } else if (score <= 7) {
      level = "Intermediate";
    } else {
      level = "Advanced";
    }

    // 🔥 Save to Firebase
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({
        "level": level,
        "score": 10,
        "track": trackId,
      });
      try {
        var getUser = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        Data.user = UserModel.fromJson(getUser.data()!);
        emit(QuizSuccess());
      }catch(e){
        emit(QuizError(e.toString()));
      }
    }catch(e){
      emit(QuizError(e.toString()));
    }
  }
}