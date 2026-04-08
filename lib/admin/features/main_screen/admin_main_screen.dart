import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/admin/features/add_course_screen/add_course_screen.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    AddCourseScreen(),
    Container(),
    Container(),
    Container(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: SizedBox(
        height: 75.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r), topRight: Radius.circular(25.r)),
          child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
              backgroundColor: Theme.of(context).cardColor,
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedIconTheme:
              IconThemeData(color: AppColors.primaryColor, size: 26.sp),
              unselectedIconTheme:
              IconThemeData(color: AppColors.thirdTextColor, size: 26.sp),
              items: [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.house_fill), label: "house"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.school), label: "school"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.person_2_fill),
                    label: "students"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: "person"),
              ]),
        ),
      ),
    );
  }
}
