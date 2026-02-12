
import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_text_styles.dart';

class ErrorViewWidget extends StatelessWidget {
  final String errorMessage;
  const ErrorViewWidget({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
       errorMessage,
        style: AppTextStyles.bodyText,
      ),
    );
  }
}
