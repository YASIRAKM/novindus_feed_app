import 'package:flutter/material.dart';
import 'package:novindus_feed_app/features/home/presentation/widgets/categories_header_delegate.dart';
import 'package:novindus_feed_app/features/home/presentation/widgets/feed_card_widget.dart';
import 'package:novindus_feed_app/features/home/presentation/widgets/profile_data_widget.dart';


import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../providers/home_provider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).loadHomeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
          
            const SliverToBoxAdapter(child: ProfileDataWidget()),

          
            SliverPersistentHeader(
              pinned: true,
              delegate: CategoriesHeaderDelegate(),
            ),

         
            Consumer<HomeProvider>(
              builder: (context, provider, child) {
                if (provider.status == HomeStatus.loading) {
                  return const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.redColor,
                      ),
                    ),
                  );
                } else if (provider.status == HomeStatus.error) {
                  return SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        provider.errorMessage ?? 'Unknown Error',
                        style: AppTextStyles.bodyText,
                      ),
                    ),
                  );
                } else if (provider.feeds.isEmpty) {
                  return  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Text(
                        'No feeds available',
                        style: AppTextStyles.bodyText,
                      ),
                    ),
                  );
                } else {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Separator logic
                        if (index.isOdd) {
                          return Container(
                            height: 12,
                            color: AppColors.black,
                          );
                        }

                        // Item logic
                        final feedIndex = index ~/ 2;
                        final feed = provider.feeds[feedIndex];
                        return FeedCardWidget(
                          feed: feed,
                          isPlaying: provider.playingFeedId == feed.id,
                          onPlay: () {
                            provider.setPlayingFeed(feed.id);
                          },
                        );
                      },
                      // Count: Items + Separators (Items - 1) => 2 * Items - 1
                      childCount: provider.feeds.length * 2 - 1,
                    ),
                  );
                }
              },
            ),

            // Bottom padding for FAB
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_feed');
        },
        backgroundColor: AppColors.redColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: AppColors.textPrimary, size: 32),
      ),
    );
  }
}
