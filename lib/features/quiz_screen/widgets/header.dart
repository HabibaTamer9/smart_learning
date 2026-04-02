import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({super.key , required this.index , required this.length });
  final int index;
  final int length;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 35.w,
          height: 35.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            color: Theme.of(context).cardColor,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close, size: 19.sp),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value: index / 10,
                backgroundColor: Colors.grey[300],
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(59.r),
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(59.r),
            color: AppColors.secondaryColor,
          ),
          child: Text(
            "${index + 1}/$length",
            style: TextStyle(
                fontSize: 14.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
