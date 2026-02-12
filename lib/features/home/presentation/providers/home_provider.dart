import 'package:flutter/material.dart';
import '../../domain/entities/home_entities.dart';
import '../../domain/repositories/home_repository.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  final HomeRepository homeRepository;

  HomeProvider({required this.homeRepository});

  HomeStatus _status = HomeStatus.initial;
  HomeStatus get status => _status;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Feed> _feeds = [];
  List<Feed> get feeds => _feeds;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _playingFeedId;
  int? get playingFeedId => _playingFeedId;

  void setPlayingFeed(int? id) {
    _playingFeedId = id;
    notifyListeners();
  }

  Future<void> loadHomeData() async {
    _status = HomeStatus.loading;
    notifyListeners();

    final categoriesResult = await homeRepository.getCategories();
    final feedsResult = await homeRepository.getFeeds();

    categoriesResult.fold(
      (failure) {
        _errorMessage = failure.message;
        _status = HomeStatus.error;
      },
      (data) {
        _categories = data;
      },
    );

    feedsResult.fold(
      (failure) {
        _errorMessage = failure.message;
        if (_status != HomeStatus.error) {
          _status = HomeStatus.error;
        }
      },
      (data) {
        _feeds = data;
        if (_status != HomeStatus.error) {
          _status = HomeStatus.loaded;
        }
      },
    );
    notifyListeners();
  }
}
