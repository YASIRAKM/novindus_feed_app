import 'package:flutter/material.dart';

import '../../domain/repositories/feed_repository.dart';
import '../../../home/domain/entities/home_entities.dart';
import '../../../home/domain/repositories/home_repository.dart';

enum FeedStatus { initial, loading, loaded, error, uploading, success }

class FeedProvider extends ChangeNotifier {
  final FeedRepository feedRepository;
  final HomeRepository homeRepository;

  FeedProvider({required this.feedRepository, required this.homeRepository});

  FeedStatus _status = FeedStatus.initial;
  FeedStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Feed> _myFeeds = [];
  List<Feed> get myFeeds => _myFeeds;

 

  

  static const int _pageSize = 10;
  int _page = 1;
  bool _hasMore = true;
  bool _isLoadMore = false;
  bool get isLoadMore => _isLoadMore;

  Future<void> loadMyFeeds({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
      _hasMore = true;
      _myFeeds.clear();
      _status = FeedStatus.loading;
    } else if (_isLoadMore || !_hasMore) {
      return;
    } else {
      _isLoadMore = true;
    }
    notifyListeners();

    final result = await feedRepository.getMyFeeds(page: _page);

    result.fold(
      (failure) {
        _status = FeedStatus.error;
        _errorMessage = failure.message;
        _isLoadMore = false;
      },
      (data) {
        if (data.isEmpty) {
          _hasMore = false;
        } else {
          _myFeeds.addAll(data);
          _page++;
          if (data.length < _pageSize) _hasMore = false;
        }
        _status = FeedStatus.loaded;
        _isLoadMore = false;
      },
    );
    notifyListeners();
  }

  
}
