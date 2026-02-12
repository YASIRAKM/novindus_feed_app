import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import 'dashed_border_painter.dart';

class FilePickerWidget extends StatefulWidget {
  final XFile? file;
  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final double height;
  final bool isVideo;

  const FilePickerWidget({
    super.key,
    required this.file,
    required this.onTap,
    required this.label,
    required this.icon,
    this.height = 100,
    this.isVideo = false,
  });

  @override
  State<FilePickerWidget> createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  @override
  void didUpdateWidget(covariant FilePickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.file != oldWidget.file) {
      _initializeVideoPlayer();
    }
  }

  Future<void> _initializeVideoPlayer() async {
    _disposeVideoPlayer();
    if (widget.isVideo && widget.file != null) {
      _videoController = VideoPlayerController.file(File(widget.file!.path));
      try {
        await _videoController!.initialize();
        if (mounted) {
          setState(() {});
        }
      } catch (e) {
        debugPrint('Error initializing video player: $e');
      }
    }
  }

  void _disposeVideoPlayer() {
    _videoController?.dispose();
    _videoController = null;
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: DashedBorderPainter(color: AppColors.border),
        child: Container(
          height: widget.height,
          width: double.infinity,
          alignment: Alignment.center,
          child: widget.file != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: widget.isVideo
                      ? (_videoController != null &&
                                _videoController!.value.isInitialized)
                            ? AspectRatio(
                                aspectRatio:
                                    _videoController!.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    VideoPlayer(_videoController!),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black.withAlpha(128),
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.redColor,
                                ),
                              )
                      : Image.file(
                          File(widget.file!.path),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                )
              : widget.isVideo
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            AppColors.textPrimary.withAlpha(204),
                            BlendMode.srcIn,
                          ),
                          image: AssetImage(AppAssets.addVideoIcon),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),

                    Text(widget.label, style: AppTextStyles.bodyText),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                            AppColors.textPrimary.withAlpha(128),
                            BlendMode.srcIn,
                          ),
                          image: AssetImage(AppAssets.addThumbnailIcon),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),

                    // Image.asset('assets/icons/add_thumbnail.png'),
                    Text(widget.label, style: AppTextStyles.secondaryText),
                  ],
                ),
        ),
      ),
    );
  }
}
