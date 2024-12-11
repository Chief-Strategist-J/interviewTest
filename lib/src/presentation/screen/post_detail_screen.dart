import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PostDetailScreen extends StatelessWidget {
  final String postTitle;
  final String postBody;

  const PostDetailScreen({super.key, required this.postTitle, required this.postBody});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          postTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            tooltip: 'Copy Post',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: '$postTitle\n\n$postBody'));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post copied to clipboard')),
              );
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    postTitle,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    postBody,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          height: 1.5, // Improved line height for readability
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
