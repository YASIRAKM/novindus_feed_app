
import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';
import 'package:novindus_feed_app/features/home/presentation/providers/home_provider.dart';
import 'package:novindus_feed_app/features/home/presentation/widgets/category_chip.dart';

import 'package:provider/provider.dart';

class CategoriesHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.background,
      alignment: Alignment.center,
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (provider.categories.isEmpty) return const SizedBox();
          return SizedBox(
            height: 45,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 45,
                    child: CategoryChip(
                      icon: Icons.explore_outlined,
                      label: "Explore",
                      isSelected: true,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: AppColors.textPrimary,
                  indent: 3,
                  endIndent: 3,
                  thickness: .3,
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.categories.length + 2,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const CategoryChip(
                          label: 'Trending',
                          isSelected: false,
                        );
                      } else if (index == 1) {
                        return const CategoryChip(
                          label: 'All Categories',
                          isSelected: false,
                        );
                      }
                      final category = provider.categories[index - 2];
                      return CategoryChip(
                        label: category.name,
                        isSelected: false,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  double get maxExtent => 60.0; 

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
