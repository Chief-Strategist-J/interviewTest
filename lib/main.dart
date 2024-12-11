import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/src/data/services/local_storage_service.dart';
import 'package:interview/src/presentation/bloc/post/post_bloc.dart';
import 'package:interview/src/presentation/bloc/post/post_event.dart';
import 'package:interview/src/presentation/screen/home_screen.dart';
import 'package:interview/src/presentation/screen/post_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostsBloc(localStorageService: LocalStorageService())..add(LoadPostsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Posts App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          '/postDetail': (context) {
            return const PostDetailScreen(
              postTitle: '',
              postBody: '',
            );
          },
        },
      ),
    );
  }
}
