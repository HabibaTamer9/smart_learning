import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.deepPurple],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: 280.w,
                  child: PageView.builder(

                    itemCount: onboardingData.length,
                    itemBuilder: (context, index) {
                      return Image.asset(onboardingData[index]["image"]!,width: 278.w,);
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
              height: MediaQuery.of(context).size.height * 0.51,
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
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: onboardingData.length,
                        itemBuilder: (context, i) {
                        var data = onboardingData[index];
                      return Column(children: [Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 50),
                        child: Center(
                          child: Text(
                            data["title"]!,
                            style: TextStyle(
                                fontSize: 24.sp, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                        Text(
                          data["subtitle"]!,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),]);
                    },
                    ),
                  ),

                  Padding(
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
                                ? Colors.deepPurpleAccent
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple),
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
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Login()));
                          }
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
