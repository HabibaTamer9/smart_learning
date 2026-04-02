import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/widgets/custom_button.dart';
import 'package:smart_learning/features/quiz_screen/quiz_screen.dart';
import 'package:smart_learning/features/track_screen/services/track_model.dart';

class GetStart extends StatelessWidget {
  const GetStart({super.key, required this.track});

  final TrackModel track;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 844.h,
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 18.w),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
              Colors.white70
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: Theme.of(context).cardColor,
                    ),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                          size: 18.sp,
                        )),
                  ),
                  Container(
                    width: 300.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                    child: Text(
                      "${track.title} Assessment",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ]),
          ),
          Positioned(
              top: 135.h,
              left: 16.w,
              right: 16.w,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(30.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/image/getstart.jpg",
                      width: 256.w,
                      height: 256.h,
                    ),
                    Text(
                        "Take a short test to help us understand your current knowledge.\nBased on your result, we will recommend the most suitable courses for you.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!.copyWith(fontWeight: FontWeight.w500,fontSize: 19.sp)
                    ),
                    CustomButton(text: "GetStart",onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizScreen(track: track)));
                    },)
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
