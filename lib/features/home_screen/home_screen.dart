import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/data.dart';
import 'package:smart_learning/features/home_screen/show_video.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> flutterCourses = [
    {
      "name": "The Net Ninja - Flutter Tutorial for Beginners",
      "videosCount": "~40 videos",
      "level": "Beginner",
      "rating": 4.8,
      "link":
          "https://www.youtube.com/playlist?list=PL4cUxeGkcC9gQeDH6xYhmO-db2mhoTSrT",
      "image": "https://img.youtube.com/vi/x0uinJvhNxI/maxresdefault.jpg"
    },
    {
      "name": "freeCodeCamp - Flutter Course for Beginners",
      "videosCount": "37 hours",
      "level": "Beginner to Intermediate",
      "rating": 4.9,
      "link": "https://www.youtube.com/watch?v=VPvVD8t02U8",
      "image": "https://img.youtube.com/vi/VPvVD8t02U8/maxresdefault.jpg"
    },
    {
      "name": "Academind - Flutter & Dart Course",
      "videosCount": "~50 videos",
      "level": "Beginner to Intermediate",
      "rating": 4.7,
      "link": "https://www.youtube.com/watch?v=1gDhl4leEzA",
      "image": "https://img.youtube.com/vi/1gDhl4leEzA/maxresdefault.jpg"
    },
    {
      "name": "Flutter Mapp - Flutter Tutorial Series",
      "videosCount": "~30 videos",
      "level": "Beginner",
      "rating": 4.6,
      "link":
          "https://www.youtube.com/playlist?list=PLtX1cJ5pFh2Yp0dF3yqz3lQ4vQ5s3m8Z",
      "image": "https://img.youtube.com/vi/5M8KZ0l8G3k/maxresdefault.jpg"
    }
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ListTile(
              title: Text(
                "Hi ${Data.user.username}",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              subtitle: Text("Find your Lessons Today!",
                  style: Theme.of(context).textTheme.bodyMedium),
              trailing: Container(
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
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              height: 229.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.secondaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let’s begin learning",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "This is your first step toward mastering new concepts.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.h),
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    height: 114.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.primaryColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Current Level",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.stars_outlined,
                                color: AppColors.yellowColor,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                Data.user.level!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              )
                            ]),
                        SizedBox(
                          height: 10,
                          width: 220.w,
                          child: LinearProgressIndicator(
                            value: 0.2,
                            backgroundColor: Colors.white,
                            color: AppColors.yellowColor,
                            borderRadius: BorderRadius.circular(59.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0.h),
              child: Text(
                "Recommended Courses For You ",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 17.sp),
              ),
            ),
            SizedBox(
              height: 277.h,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: flutterCourses.length,
                  itemBuilder: (context, i) {
                    var course = flutterCourses[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowVideo(
                              videos: course["link"],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 220.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        margin: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 145.h,
                              width: 192.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(course["image"]),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              course["name"],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(course["videosCount"],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                Text("⭐ ${course["rating"]}",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium)
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
