import 'dart:convert';

import 'package:flutter_application_1/pagination/post_model.dart';
import 'package:http/http.dart' as http;

class PostService {
  Future<List<PostModel>> getPosts({int page = 1, int limit = 10}) async {
    final response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit"));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw Exception('failed to load datas');
    }
  }
}
