import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/features/quiz_screen/services/question_model.dart';

class CustomQuestionUi extends StatelessWidget {
  const CustomQuestionUi({super.key, required this.question, required this.index, this.onChanged, this.selectedAnswer});
  final QuestionModel question;
  final int index;
  final int? selectedAnswer;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Choose the correct answer",
          style: TextStyle(
              fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.h),

        Text(
          "${index + 1}. ${question.question}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 20),

        // 🔹 الاختيارات
        ...List.generate(question.options.length, (index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            height: 56.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border:
                Border.all(color: Color(0xffC3C1C7)),
                color: Colors.white),
            child: RadioListTile(
              title: Text(
                question.options[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Color(0xff4C4C4E)),
              ),
              value: index,
              groupValue: selectedAnswer,
              activeColor: AppColors.secondaryColor,
              onChanged: onChanged
            ),
          );
        }),
      ],
    );
  }
}
