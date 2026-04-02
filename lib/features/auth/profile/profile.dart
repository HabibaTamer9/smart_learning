import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/data.dart';
import 'package:smart_learning/features/auth/profile/widget/custom_list_tile.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40.0.h),
      child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Theme.of(context).cardColor,
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                        size: 24.sp,
                      )),
                ),
                Text(
                  "Profile",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.r),
                    color: Theme.of(context).cardColor,
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.black,
                        size: 24.sp,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 360.w,
            height: 750.h,
            child: Stack(
              children: [
                Positioned(
                    right: 15.w,
                    left: 15.w,
                    top: 60.h,
                    child: Container(
                      padding: EdgeInsets.only(top: 67.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            Data.user.username,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            Data.user.email,
                            style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff545454)),
                          ),
                          CustomListTile(
                              title: "Edit Profile",
                              icon: Icons.person_2_outlined,
                              onTap: () {}), CustomListTile(
                              title: "Notifications",
                              icon: Icons.notifications_none,
                              onTap: () {}), CustomListTile(
                              title: "Language",
                              icon: Icons.language_outlined,
                              onTap: () {}), CustomListTile(
                              title: "Dark Mode",
                              icon: Icons.dark_mode_outlined,
                              onTap: () {}), CustomListTile(
                              title: "Help Center",
                              icon: Icons.help_outline_outlined,
                              onTap: () {}), CustomListTile(
                              title: "Invite Friends",
                              icon: Icons.person_add_alt_1_outlined,
                              onTap: () {}), CustomListTile(
                              title: "setting",
                              icon: Icons.settings_outlined,
                              onTap: () {}), CustomListTile(
                              title: "Logout",
                              icon: Icons.logout_outlined,
                              onTap: () {}), CustomListTile(
                              title: "Terms & Conditions",
                              icon: Icons.shield_outlined,
                              onTap: () {}),
                        ],
                      ),
                    )),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                        radius: 60.r,
                        backgroundColor: AppColors.primaryColor,
                        child: CircleAvatar(
                            radius: 55.r,
                            backgroundColor: AppColors.thirdTextColor,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  width: 36.w,
                                  height: 36.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Theme.of(context).cardColor,
                                      border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 2.w)),
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.image_outlined,
                                        size: 25,
                                        color: AppColors.primaryColor,
                                      ))),
                            )))),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
