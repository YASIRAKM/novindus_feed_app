import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_text_styles.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No feeds available',
        style: AppTextStyles.bodyText,
      ),
    );
  }
}