import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/src/core/utils/custom_functions.dart';
import 'package:interview/src/data/models/post.dart';
import 'package:interview/src/presentation/bloc/post/post_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_event.dart';
import 'package:interview/src/presentation/bloc/post/post_state.dart';
import 'package:interview/src/presentation/screen/post_detail_screen.dart';
import 'package:interview/src/presentation/widget/error_widget.dart';
import 'package:interview/src/presentation/widget/post_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void onTapOfList(BuildContext context, Post post, int index) {
    debugPrint("Tapped on post: $index");
    context.read<PostsBloc>().add(MarkPostReadEvent(index));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailScreen(
          postTitle: post.title,
          postBody: post.body,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.read<PostsBloc>().add(LoadPostsEvent());

    return Scaffold(
      appBar: buildCostomAppBar(context),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.status == PostStatus.loading) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.primary,
                ),
              ),
            );
          }

          if (state.status == PostStatus.error) {
            return const ErrorCustomWidget();
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<PostsBloc>().add(LoadPostsEvent());
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Material(
                  color: Colors.transparent,
                  child: PostTile(
                    post: post,
                    index: index,
                    onTap: () {
                      onTapOfList(context, post, index);
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
