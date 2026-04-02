import 'package:smart_learning/features/quiz_screen/services/question_model.dart';

class TrackModel {
  final String id;
  final String title;
  final String image;
  final List<QuestionModel> question;

  TrackModel(
      {required this.id,
      required this.title,
      required this.image,
      required this.question});
}
