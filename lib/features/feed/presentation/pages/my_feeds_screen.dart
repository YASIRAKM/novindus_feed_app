import 'package:flutter/material.dart';
import 'package:novindus_feed_app/features/home/presentation/widgets/feed_card_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../providers/feed_provider.dart';

class MyFeedsScreen extends StatefulWidget {
  const MyFeedsScreen({super.key});

  @override
  State<MyFeedsScreen> createState() => _MyFeedsScreenState();
}

class _MyFeedsScreenState extends State<MyFeedsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FeedProvider>(
        context,
        listen: false,
      ).loadMyFeeds(refresh: true);
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<FeedProvider>(context, listen: false).loadMyFeeds();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              size: 16,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('My Feed', style: AppTextStyles.appBarTitle),
      ),
      body: Consumer<FeedProvider>(
        builder: (context, provider, child) {
          if (provider.status == FeedStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.redColor),
            );
          } else if (provider.status == FeedStatus.error) {
            return Center(
              child: Text(
                provider.errorMessage ?? 'Unknown Error',
                style: AppTextStyles.bodyText,
              ),
            );
          } else if (provider.status == FeedStatus.loaded ||
              provider.status == FeedStatus.success) {
            if (provider.myFeeds.isEmpty) {
              return Center(
                child: Text('No feeds found', style: AppTextStyles.bodyText),
              );
            }
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Container(height: 12, color: AppColors.black);
              },
              padding: const EdgeInsets.only(top: 16),
              controller: _scrollController,
              itemCount:
                  provider.myFeeds.length + (provider.isLoadMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.myFeeds.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.redColor,
                      ),
                    ),
                  );
                }
                return FeedCardWidget(feed: provider.myFeeds[index]);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
