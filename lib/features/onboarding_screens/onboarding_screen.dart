import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';

import '../../core/const/app_size.dart';
import '../auth/login_screen/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int index = 0;
  PageController pageController = PageController();
  List<Map<String, String>> onboardingData = [
    {
      "image": "assets/image/image2.png",
      "title": "Choose Your Learning Track",
      "subtitle":
          "Explore different learning tracks and choose the field you are interested in."
    },
    {
      "image": "assets/image/image1.png",
      "title": "Test Your Knowledge Level",
      "subtitle":
          "Take a quick test to discover your level and get the right courses for you."
    },
    {
      "image": "assets/image/image3.png",
      "title": "Track Your Learning Progress",
      "subtitle": "Stay motivated and see how your skills improve over time."
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: AppSize.width,
            height: AppSize.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, AppColors.primaryColor],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppSize.height * 0.45,
                  width: 280.w,
                  child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        onboardingData[index]["image"]!,
                        width: 278.w,
                      );
                    },
                    onPageChanged: (val) {
                      setState(() {
                        index = val;
                      });
                    },
                    controller: pageController,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: -50,
            left: -50,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 94.5),
              height: AppSize.height * 0.51,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(260),
                    topRight: Radius.circular(260)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50),
                        child: Center(
                          child: Text(
                            onboardingData[index]["title"]!,
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Text(
                        onboardingData[index]["subtitle"]!,
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingData.length,
                            (i) => Container(
                              margin: const EdgeInsets.all(3.0),
                              width: index == i ? 20 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: index == i
                                    ? AppColors.secondaryColor
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        )),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (index < onboardingData.length - 1) {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
