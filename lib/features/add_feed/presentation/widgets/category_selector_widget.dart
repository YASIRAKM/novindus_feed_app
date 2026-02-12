import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../home/domain/entities/home_entities.dart';

class CategorySelectorWidget extends StatefulWidget {
  final List<Category> categories;
  final Set<int> selectedCategoryIds;
  final Function(int) onCategorySelected;

  const CategorySelectorWidget({
    super.key,
    required this.categories,
    required this.selectedCategoryIds,
    required this.onCategorySelected,
  });

  @override
  State<CategorySelectorWidget> createState() => _CategorySelectorWidgetState();
}

class _CategorySelectorWidgetState extends State<CategorySelectorWidget> {
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Loading categories...',
          style: AppTextStyles.secondaryText.copyWith(
            color: AppTextStyles.secondaryText.color?.withOpacity(0.5),
          ),
        ),
      );
    }
    return ValueListenableBuilder<bool>(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        return Column(
          children: [
            _CategoryHeader(
              isExpanded: isExpanded,
              onTap: () {
                _isExpanded.value = !isExpanded;
              },
            ),
            const SizedBox(height: 16),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: isExpanded ? null : 90,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: widget.categories.map((category) {
                      final isSelected = widget.selectedCategoryIds.contains(
                        category.id,
                      );
                      return GestureDetector(
                        onTap: () => widget.onCategorySelected(category.id),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.surface
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.redColor
                                  : AppColors.border,
                            ),
                          ),
                          child: Text(
                            category.name,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final VoidCallback onTap;
  final bool isExpanded;
  const _CategoryHeader({required this.onTap, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Categories This Project', style: AppTextStyles.sectionTitle),
          Row(
            children: [
              Text(
                isExpanded ? 'View Less' : 'View All',
                style: AppTextStyles.bodyText,
              ),
              Icon(
                isExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.arrow_circle_right_outlined,
                size: 16,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
