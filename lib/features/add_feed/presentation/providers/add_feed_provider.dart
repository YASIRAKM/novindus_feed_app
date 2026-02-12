import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../domain/repositories/add_feed_repository.dart';
import '../../../home/domain/entities/home_entities.dart';
import '../../../home/domain/repositories/home_repository.dart';

enum AddFeedStatus { initial, loading, loaded, error, uploading, success }

class AddFeedProvider extends ChangeNotifier {
  final AddFeedRepository addFeedRepository;
  final HomeRepository homeRepository;

  AddFeedProvider({
    required this.addFeedRepository,
    required this.homeRepository,
  });

  AddFeedStatus _status = AddFeedStatus.initial;
  AddFeedStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  double _uploadProgress = 0.0;
  double get uploadProgress => _uploadProgress;

  XFile? _videoFile;
  XFile? get videoFile => _videoFile;

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  final Set<int> _selectedCategoryIds = {};
  List<int> get selectedCategoryIds => _selectedCategoryIds.toList();

  final ImagePicker _picker = ImagePicker();

  Future<void> loadCategories() async {
    final result = await homeRepository.getCategories();

    result.fold(
      (failure) {
        print("Failed to load categories: ${failure.message}");
      },
      (data) {
        _categories = data;
        notifyListeners();
      },
    );
  }

  Future<void> pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
     
      if (!video.path.toLowerCase().endsWith('.mp4')) {
        _errorMessage = "Only MP4 videos are allowed.";
        _videoFile = null;
        notifyListeners();
        return;
      }

      
      final VideoPlayerController controller = VideoPlayerController.file(
        File(video.path),
      );
      try {
        await controller.initialize();
        final Duration duration = controller.value.duration;
        if (duration.inMinutes > 5) {
          _errorMessage = "Video duration must be less than 5 minutes.";
          _videoFile = null;
        } else {
          _videoFile = video;
          _errorMessage = null;
        }
      } catch (e) {
        _errorMessage = "Failed to validate video duration.";
        _videoFile = null;
        print("Error validating video: $e");
      } finally {
        await controller.dispose();
        notifyListeners();
      }
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = image;
      notifyListeners();
    }
  }

  void toggleCategory(int id) {
    if (_selectedCategoryIds.contains(id)) {
      _selectedCategoryIds.remove(id);
    } else {
      _selectedCategoryIds.add(id);
    }
    notifyListeners();
  }

  Future<bool> uploadFeed(String desc) async {
    if (_videoFile == null ||
        _imageFile == null ||
        _selectedCategoryIds.isEmpty) {
      _errorMessage = "Please fill all fields";
      notifyListeners();
      return false;
    }

    _status = AddFeedStatus.uploading;
    _uploadProgress = 0.0;
    notifyListeners();

    final result = await addFeedRepository.uploadFeed(
      video: _videoFile!,
      image: _imageFile!,
      desc: desc,
      categoryIds: _selectedCategoryIds.toList(),
      onSendProgress: (sent, total) {
        _uploadProgress = sent / total;
        notifyListeners();
      },
    );

    return result.fold(
      (failure) {
        _status = AddFeedStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (success) {
        _status = AddFeedStatus.success;
        _errorMessage = null;
        resetForm();
        notifyListeners();
        return true;
      },
    );
  }

  void resetForm() {
    _videoFile = null;
    _imageFile = null;
    _selectedCategoryIds.clear();
    _uploadProgress = 0.0;
    _status = AddFeedStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
