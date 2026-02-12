
import 'package:flutter/material.dart';

class ProfileImageAvatar extends StatelessWidget {
  final String imageUrl;
  bool isUserImage;
  ProfileImageAvatar({
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
              ? AssetImage('assets/images/user_profile.png')
              : AssetImage('assets/images/post_profile.png')
          : NetworkImage(imageUrl),
      onBackgroundImageError: (_, _) {},
      backgroundColor: Colors.grey[800],
    );
  }
}
