import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/post_options_bloc/post_options_bloc.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_page.dart';
import 'package:posts_app/injacttion_container.dart';

import 'core/theme_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PostsBloc>()..add(GetPostsEvent()),
        ),
        BlocProvider(
          create: (_) => sl<PostOptionsBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: themeApp,
        debugShowCheckedModeBanner: false,
        title: 'Posts App',
        home: PostsPage(),
      ),
    );
  }
}
