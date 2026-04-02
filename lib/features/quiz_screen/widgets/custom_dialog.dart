import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: 330.w,
          height: 442.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: AppColors.backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 300.w,
                height: 170.h,
                child: Stack(
                  children: [
                    Positioned(
                      child: Center(
                        child: SizedBox(
                          width: 250.w,
                          height: 160.h,
                          child: Image.asset("assets/image/effect.png"),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 30.h,
                        right: 0,
                        left: 0,
                        child: Image.asset(
                          "assets/image/person.png",
                          width: 140.w,
                          height: 140.h,
                        )),
                  ],
                ),
              ),
              Text(
                "Congratulations",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "You have successfully completed test.We are now calculating your level to show you the most suitable courses",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 19.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 40.w,
                height: 40.h,
                child: Lottie.asset(
                  'assets/lettiefile/loading_gray.json',
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ));
  }
}
