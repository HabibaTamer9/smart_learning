import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';
import 'package:smart_learning/core/data.dart';
import 'package:smart_learning/features/track_screen/services/track_model.dart';
import 'package:smart_learning/features/track_screen/services/tracks_data.dart';
import 'package:smart_learning/features/track_screen/widgets/custom_track_card.dart';

class TrackSelectionScreen extends StatelessWidget {
  const TrackSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 18.w),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor,
              Colors.white70
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi ,${Data.user.username}",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text("Explore available tracks and start learning today.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.white))
                ]),
          ),
          // 🔹 عرض التراكات
          Positioned(
              top: 150.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16.h,
                        crossAxisSpacing: 10.w,
                        mainAxisExtent: 170.h),
                    itemCount: TracksData.tracks.length,
                    itemBuilder: (context, index) {
                      final TrackModel track = TracksData.tracks[index];
                      return CustomTrackCard(track: track);
                    }),
              )),
        ],
      ),
    );
  }
}
