import 'package:flutter_application_1/pagination/post_model.dart';
import 'package:flutter_application_1/pagination/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostNotifier extends StateNotifier<List<PostModel>> {
  PostNotifier(this.service) : super([]) {
    fetchMorePosts();
  }

  final PostService service;
  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool hasMore = true;

  Future<void> fetchMorePosts() async {
    if (_isLoading || !hasMore) return;
    _isLoading = true;

    final newPosts = await service.getPosts(page: _page, limit: _limit);
    if (newPosts.isEmpty) {
      hasMore = false;
    } else {
      state = [...state, ...newPosts];
      _page++;
    }
    _isLoading = false;
  }

  void refresh() {
    state = [];
    _page = 1;
    hasMore = true;
    fetchMorePosts();
  }

  bool get isLoading => _isLoading;
}
