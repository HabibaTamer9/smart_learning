import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_learning/core/const/app_colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  final String title;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 28.sp),
      title: Text(
       title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.profileTextColor,
            ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}
