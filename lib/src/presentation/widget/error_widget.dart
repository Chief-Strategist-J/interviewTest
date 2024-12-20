import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_event.dart';

class ErrorCustomWidget extends StatelessWidget {
  const ErrorCustomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading posts',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
          TextButton(
            onPressed: () {
              context.read<PostsBloc>().add(LoadPostsEvent());
            },
            child: const Text("Retry"),
          )
        ],
      ),
    );
  }
}
