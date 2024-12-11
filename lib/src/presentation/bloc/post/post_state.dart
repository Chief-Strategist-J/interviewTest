import 'package:equatable/equatable.dart';
import 'package:interview/src/data/models/post.dart';

enum PostStatus { initial, loading, loaded, error }

class PostsState extends Equatable {
  final List<Post> posts;
  final PostStatus status;

  const PostsState({this.posts = const [], this.status = PostStatus.initial});

  PostsState copyWith({List<Post>? posts, PostStatus? status}) {
    return PostsState(posts: posts ?? this.posts, status: status ?? this.status);
  }

  @override
  List<Object> get props => [posts, status];
}
