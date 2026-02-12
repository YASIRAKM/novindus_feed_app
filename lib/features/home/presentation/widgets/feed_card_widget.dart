import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/common_widget/profile_image.dart';
import 'package:novindus_feed_app/core/utils/date_formatter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

import '../../../home/domain/entities/home_entities.dart';
import '../../../home/presentation/widgets/video_player_widget.dart';

class FeedCardWidget extends StatefulWidget {
  final Feed feed;
  final bool isPlaying;
  final VoidCallback? onPlay;
  final bool showMoreOption;

  const FeedCardWidget({
    super.key,
    required this.feed,
    this.isPlaying = false,
    this.onPlay,
    this.showMoreOption = false,
  });

  @override
  State<FeedCardWidget> createState() => _FeedCardWidgetState();
}

class _FeedCardWidgetState extends State<FeedCardWidget> {
  bool _localIsPlaying = false;
  final ValueNotifier<bool> _isExpanded = ValueNotifier(false);

  bool get _isPlaying =>
      widget.onPlay != null ? widget.isPlaying : _localIsPlaying;

  @override
  void dispose() {
    _isExpanded.dispose();
    super.dispose();
  }

  void _togglePlay() {
    if (widget.onPlay != null) {
      widget.onPlay!();
    } else {
      setState(() {
        _localIsPlaying = !_localIsPlaying;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                ProfileImageAvatar(imageUrl: widget.feed.user.image),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feed.user.name,
                      style: AppTextStyles.bodyText.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      DateFormatter.timeAgo(widget.feed.createdAt),
                      style: AppTextStyles.secondaryText.copyWith(fontSize: 12),
                    ),
                  ],
                ),
                if (widget.showMoreOption) ...[
                  const Spacer(),
                  Icon(Icons.more_vert, color: AppColors.textSecondary),
                ],
              ],
            ),
          ),

        
          GestureDetector(
            onTap: _togglePlay,
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: _isPlaying
                  ? VideoPlayerWidget(videoUrl: widget.feed.videoUrl)
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.feed.thumbnailUrl,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[900],
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.redColor,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey[900],
                            child: const Center(
                              child: Icon(
                                Icons.broken_image,
                                color: AppColors.border,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ValueListenableBuilder<bool>(
              valueListenable: _isExpanded,
              builder: (context, isExpanded, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feed.description,
                      maxLines: isExpanded ? null : 3,
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: AppTextStyles.bodyText.copyWith(
                        color: AppColors.textPrimary.withOpacity(0.8),
                        height: 1.4,
                      ),
                    ),
                    if (widget.feed.description.length > 100) ...[
                      GestureDetector(
                        onTap: () {
                          _isExpanded.value = !isExpanded;
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            isExpanded ? 'See less' : 'See more',
                            style: AppTextStyles.bodyText.copyWith(
                              color: AppColors.redColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
