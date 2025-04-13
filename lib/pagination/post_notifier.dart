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

  List<PostModel> _allPosts = [];
  String _searchQuery = '';

 

  Future<void> fetchMorePosts() async {
    if (_isLoading || !hasMore) return;
    _isLoading = true;

    final newPosts = await service.getPosts(page: _page, limit: _limit);
    if (newPosts.isEmpty) {
      hasMore = false;
    } else {
      _allPosts = [..._allPosts, ...newPosts];
      applySearch();
      _page++;
    }
    _isLoading = false;
  }
   void applySearch() {
    if (_searchQuery.isEmpty) {
      state = [..._allPosts];
    } else {
      state = _allPosts
          .where(
            (post) => post.title.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }
  }

  void search(String query) {
    _searchQuery = query;
    applySearch();
  }

  void refresh() {
    state = [];
    _allPosts=[];
    _page = 1;
    hasMore = true;
    _searchQuery='';
    fetchMorePosts();
  }

  bool get isLoading => _isLoading;
}
