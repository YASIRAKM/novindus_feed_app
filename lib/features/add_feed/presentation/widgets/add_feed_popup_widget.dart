import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';
import 'package:novindus_feed_app/core/constants/app_text_styles.dart';
import 'package:novindus_feed_app/features/add_feed/presentation/providers/add_feed_provider.dart';

import 'package:provider/provider.dart';

class AddFeedProgressDialog extends StatelessWidget {
  final bool isSuccess;
  const AddFeedProgressDialog({super.key, this.isSuccess = false});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddFeedProvider>(
      builder: (context, provider, child) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSuccess) ...[
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_rounded,
                            color: Colors.green,
                            size: 48,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Upload Successful!",
                    style: AppTextStyles.sectionTitle.copyWith(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your post has been shared.",
                    style: AppTextStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ] else ...[
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: provider.uploadProgress,
                          color: AppColors.redColor,
                          strokeWidth: 8,
                          strokeCap: StrokeCap.round,
                          backgroundColor: AppColors.border.withOpacity(0.3),
                        ),
                        Text(
                          '${(provider.uploadProgress * 100).toInt()}%',
                          style: AppTextStyles.sectionTitle.copyWith(
                            fontSize: 16,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Uploading Video',
                    style: AppTextStyles.sectionTitle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please wait while we process your request...',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyText.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
