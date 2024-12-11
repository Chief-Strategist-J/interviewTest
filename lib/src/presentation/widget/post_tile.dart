import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/src/data/models/post.dart';
import 'package:interview/src/presentation/bloc/post/post_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_event.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final int index;
  final VoidCallback onTap;

  const PostTile({
    super.key,
    required this.post,
    required this.index,
    required this.onTap,
  });

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.post.isVisible && widget.post.elapsedTime < widget.post.timerDuration) {
      _startTimer();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pauseTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pauseTimer();
    } else if (state == AppLifecycleState.resumed) {
      if (widget.post.isVisible && widget.post.elapsedTime < widget.post.timerDuration) {
        _startTimer();
      }
    }
  }

  void _startTimer() {
    _pauseTimer();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.post.elapsedTime < widget.post.timerDuration) {
        context.read<PostsBloc>().add(UpdatePostTimerEvent(widget.index, widget.post.elapsedTime + 1));
      } else {
        _pauseTimer();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.post.isVisible && widget.post.elapsedTime < widget.post.timerDuration && _timer == null) {
      _startTimer();
    }

    return Visibility(
      visible: widget.post.isVisible,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: widget.post.isRead ? Colors.white : Colors.yellow[100],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.post.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  const Icon(Icons.timer, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.post.timerDuration - widget.post.elapsedTime} sec',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
