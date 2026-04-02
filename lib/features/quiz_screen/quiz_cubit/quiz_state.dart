abstract class QuizState{}

class QuizInitial extends QuizState{}
class QuizLoading extends QuizState{}
class QuizNextQuestion extends QuizState{
  final int currentIndex;
  QuizNextQuestion(this.currentIndex);
}
class QuizSuccess extends QuizState{}
class QuizError extends QuizState{
  String error;
  QuizError(this.error);
}