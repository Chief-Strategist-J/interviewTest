import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_state.dart';

AppBar buildCostomAppBar(BuildContext context) {
  return AppBar(
    elevation: 0,
    title: Text(
      'Posts',
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
    ),
    centerTitle: false,
    actions: [
      BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Chip(
              label: Text('Total Posts: ${state.posts.length}', style: Theme.of(context).textTheme.bodyMedium),
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          );
        },
      ),
    ],
  );
}

