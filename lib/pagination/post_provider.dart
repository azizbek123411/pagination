import 'package:flutter_application_1/pagination/post_model.dart';
import 'package:flutter_application_1/pagination/post_notifier.dart';
import 'package:flutter_application_1/pagination/post_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final postProvider = StateNotifierProvider<PostNotifier, List<PostModel>>(
  (ref) => PostNotifier(
    PostService(),
  ),
);
