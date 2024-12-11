import 'dart:async';
import 'dart:convert';

import 'package:interview/src/data/models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _postsKey = 'posts_key';

  Future<List<Post>> getPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = prefs.getStringList(_postsKey) ?? [];

    return postsJson.map((postJson) {
      final Map<String, dynamic> postMap = json.decode(postJson);
      return Post(
        title: postMap['title'],
        body: postMap['body'],
        isRead: postMap['isRead'],
        timerDuration: postMap['timerDuration'],
        elapsedTime: postMap['elapsedTime'],
        isVisible: postMap['isVisible'],
      );
    }).toList();
  }

  Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = posts
        .map((post) => json.encode({
              'title': post.title,
              'body': post.body,
              'isRead': post.isRead,
              'timerDuration': post.timerDuration,
              'elapsedTime': post.elapsedTime,
              'isVisible': post.isVisible,
            }))
        .toList();

    await prefs.setStringList(_postsKey, postsJson);
  }
}
