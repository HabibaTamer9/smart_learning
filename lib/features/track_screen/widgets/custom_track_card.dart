import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/features/quiz_screen/get_start.dart';
import 'package:smart_learning/features/track_screen/services/track_model.dart';

class CustomTrackCard extends StatelessWidget {
  const CustomTrackCard({super.key, required this.track});
  final TrackModel track;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GetStart(
              track: track,
            ),
          ),
        );
      },
      child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r)),
                        image: DecorationImage(
                          image: AssetImage(track.image),
                          fit: BoxFit.cover,
                        ),
                      ))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    track.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
