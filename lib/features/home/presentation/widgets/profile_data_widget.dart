import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/common_widget/profile_image.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';
import 'package:novindus_feed_app/core/constants/app_text_styles.dart';
import 'package:novindus_feed_app/core/constants/app_assets.dart';
import 'package:novindus_feed_app/core/routes/routes.dart';

class ProfileDataWidget extends StatelessWidget {
  const ProfileDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello Maria',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Welcome back to Section',
                style: AppTextStyles.secondaryText,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.myFeeds);
            },
            child: ProfileImageAvatar(
              imageUrl: "",
              isUserImage: true,
            ),
          ),
        ],
      ),
    );
  }
}
