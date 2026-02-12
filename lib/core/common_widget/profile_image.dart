import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_assets.dart';

class ProfileImageAvatar extends StatelessWidget {
  final String imageUrl;
  final bool isUserImage;
  const ProfileImageAvatar({
    super.key,
    required this.imageUrl,
    this.isUserImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: imageUrl.isEmpty || imageUrl == ''
          ? isUserImage
                ? AssetImage(AppAssets.userProfileImage)
                : AssetImage(AppAssets.postProfileImage)
          : NetworkImage(imageUrl),
      onBackgroundImageError: (_, _) {},
      backgroundColor: Colors.grey[800],
    );
  }
}
