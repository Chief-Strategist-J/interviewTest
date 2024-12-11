import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/src/data/models/post.dart';
import 'package:interview/src/data/repositories/post_repository.dart';
import 'package:interview/src/data/services/local_storage_service.dart';
import 'package:interview/src/presentation/bloc/post/post_event.dart';
import 'package:interview/src/presentation/bloc/post/post_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final LocalStorageService localStorageService;

  PostsBloc({required this.localStorageService}) : super(const PostsState()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<MarkPostReadEvent>(_onMarkPostRead);
    on<UpdatePostTimerEvent>(_onUpdatePostTimer);
    on<TogglePostVisibilityEvent>(_onTogglePostVisibility);
  }

  Future<void> _onLoadPosts(LoadPostsEvent event, Emitter<PostsState> emit) async {
    try {
      emit(state.copyWith(status: PostStatus.loading));

      List<Post> storedPosts = await localStorageService.getPosts();

      if (storedPosts.isEmpty) {
        final postsRepository = PostsRepository();
        storedPosts = await postsRepository.fetchPosts();
      }

      emit(state.copyWith(posts: storedPosts, status: PostStatus.loaded));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.error));
    }
  }

  void _onMarkPostRead(MarkPostReadEvent event, Emitter<PostsState> emit) {
    final updatedPosts = List<Post>.from(state.posts);
    updatedPosts[event.index] = updatedPosts[event.index].copyWith(
      isRead: true,
      elapsedTime: updatedPosts[event.index].timerDuration,
    );

    emit(state.copyWith(posts: updatedPosts));
    localStorageService.savePosts(updatedPosts);
  }

  void _onUpdatePostTimer(UpdatePostTimerEvent event, Emitter<PostsState> emit) {
    final updatedPosts = List<Post>.from(state.posts);
    updatedPosts[event.index] = updatedPosts[event.index].copyWith(elapsedTime: event.elapsedTime);
    emit(state.copyWith(posts: updatedPosts));
  }

  void _onTogglePostVisibility(TogglePostVisibilityEvent event, Emitter<PostsState> emit) {
    final updatedPosts = List<Post>.from(state.posts);
    updatedPosts[event.index] = updatedPosts[event.index].copyWith(isVisible: event.isVisible);
    emit(state.copyWith(posts: updatedPosts));
  }
}
