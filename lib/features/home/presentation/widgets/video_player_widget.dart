import 'package:flutter/material.dart';
import 'package:novindus_feed_app/core/constants/app_colors.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );
    await _videoPlayerController.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,

      allowFullScreen: true,
      allowMuting: true,
      showControls: true,


      allowPlaybackSpeedChanging: false,
      showOptions: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColors.redColor,
        handleColor: AppColors.redColor,
        backgroundColor: Colors.grey.withOpacity(0.5),
        bufferedColor: AppColors.redColor.withOpacity(0.3),
      ),
      cupertinoProgressColors: ChewieProgressColors(
        playedColor: AppColors.redColor,
        handleColor: AppColors.redColor,
        backgroundColor: Colors.grey.withOpacity(0.5),
        bufferedColor: AppColors.redColor.withOpacity(0.3),
      ),
      placeholder: Center(
        child: CircularProgressIndicator(color: AppColors.redColor),
      ),
      autoInitialize: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        );
      },
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController != null &&
        _chewieController!.videoPlayerController.value.isInitialized) {
      return AspectRatio(
        aspectRatio: _videoPlayerController.value.aspectRatio,
        child: Chewie(controller: _chewieController!),
      );
    } else {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(
          child: CircularProgressIndicator(color: AppColors.redColor),
        ),
      );
    }
  }
}
