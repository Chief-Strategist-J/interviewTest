import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:interview/src/data/models/post.dart';

class PostsRepository {
  final String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse('$_baseUrl/posts'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print("\n\n\bGet List Of Posts");
      return jsonData.map((data) => Post.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // I write this but never used becouse I never need to use this
  Future<Post> fetchPostById(int postId) async {
    final response = await http.get(Uri.parse('$_baseUrl/posts/$postId'));
    if (response.statusCode == 200) {
      print("\b\n\nGet Post By ID");
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
