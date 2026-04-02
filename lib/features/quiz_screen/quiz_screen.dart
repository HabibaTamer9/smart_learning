import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/widgets/custom_button.dart';
import 'package:smart_learning/features/main_screen.dart';
import 'package:smart_learning/features/quiz_screen/quiz_cubit/quiz_cubit.dart';
import 'package:smart_learning/features/quiz_screen/quiz_cubit/quiz_state.dart';
import 'package:smart_learning/features/quiz_screen/services/question_model.dart';
import 'package:smart_learning/features/quiz_screen/widgets/custom_dialog.dart';
import 'package:smart_learning/features/quiz_screen/widgets/custom_question_ui.dart';
import 'package:smart_learning/features/quiz_screen/widgets/header.dart';
import 'package:smart_learning/features/track_screen/services/track_model.dart';

class QuizScreen extends StatefulWidget {
  final TrackModel track;

  const QuizScreen({super.key, required this.track});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswer;
  int currentQuestionIndex = 0;
  late List<QuestionModel> questions;
  late QuestionModel question;

  @override
  void initState() {
    super.initState();
    questions = widget.track.question;
  }

  @override
  Widget build(BuildContext context) {
    question = questions[0];
    return BlocProvider(
      create: (_) => QuizCubit(),
      child: BlocConsumer<QuizCubit, QuizState>(listener: (context, state) {
        if (state is QuizNextQuestion) {
          question = questions[state.currentIndex];
          currentQuestionIndex = state.currentIndex;
        } else if (state is QuizSuccess) {
          showDialog(
            context: context,
            builder: (context) => CustomDialog(),
          );
          Future.delayed(Duration(seconds: 3), () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          });
        } else if (state is QuizError) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Error"),
                    content: Text("SomeThing Went Wrong"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Ok"))
                    ],
                  ));
        }
      }, builder: (context, state) {
        return Scaffold(
          body: SizedBox(
            height: 844.h,
            child: Stack(
              children: [
                Container(
                    height: 844.h,
                    padding:
                        EdgeInsets.symmetric(vertical: 40.h, horizontal: 18.w),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          AppColors.primaryColor,
                          AppColors.secondaryColor,
                          Colors.white70
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        QuizHeader(
                            index: currentQuestionIndex,
                            length: questions.length)
                      ],
                    )),
                Positioned(
                    top: 135.h,
                    left: 16.w,
                    right: 16.w,
                    bottom: 0,
                    child: Container(
                        padding: EdgeInsets.all(16.sp),
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Column(
                          children: [
                            CustomQuestionUi(
                              question: question,
                              index: currentQuestionIndex,
                              onChanged: (value) {
                                setState(() {
                                  selectedAnswer = value as int;
                                });
                              },
                              selectedAnswer: selectedAnswer,
                            ),
                            Spacer(),
                            CustomButton(
                                text:
                                    currentQuestionIndex == questions.length - 1
                                        ? "Submit"
                                        : "Next",
                                onPressed: selectedAnswer == null
                                    ? null
                                    : () {
                                        context.read<QuizCubit>().nextQuestion(
                                            selectedAnswer!,
                                            widget.track,
                                            currentQuestionIndex);
                                      }),
                          ],
                        ))),
              ],
            ),
          ),
        );
      }),
    );
  }
}
