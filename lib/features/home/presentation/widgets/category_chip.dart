import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';


class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData? icon;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.surface : Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? AppColors.redColor : AppColors.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.textPrimary, size: 18),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
