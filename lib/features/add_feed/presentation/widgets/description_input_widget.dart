import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class DescriptionInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const DescriptionInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add Description', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: AppTextStyles.bodyText.copyWith(
            color: AppColors.textPrimary.withOpacity(0.8),
          ),
          decoration: InputDecoration(
            hintText: 'Enter Description ....',
            hintStyle: AppTextStyles.hintText,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.border.withOpacity(0.7)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.border.withOpacity(0.7)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.border.withOpacity(0.7)),
            ),
            filled: true,
            fillColor: AppColors.buttonFill.withOpacity(.3),
          ),
          maxLines: 4,
          validator: (value) => value!.isEmpty ? 'Enter description' : null,
        ),
      ],
    );
  }
}
