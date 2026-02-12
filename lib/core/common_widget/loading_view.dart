
import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.redColor,
      ),
    );
  }
}
