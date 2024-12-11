import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object> get props => [];
}

class LoadPostsEvent extends PostsEvent {}

class MarkPostReadEvent extends PostsEvent {
  final int index;

  const MarkPostReadEvent(this.index);

  @override
  List<Object> get props => [index];
}

class UpdatePostTimerEvent extends PostsEvent {
  final int index;
  final int elapsedTime;

  const UpdatePostTimerEvent(this.index, this.elapsedTime);

  @override
  List<Object> get props => [index, elapsedTime];
}

class TogglePostVisibilityEvent extends PostsEvent {
  final int index;
  final bool isVisible;

  const TogglePostVisibilityEvent(this.index, this.isVisible);

  @override
  List<Object> get props => [index, isVisible];
}