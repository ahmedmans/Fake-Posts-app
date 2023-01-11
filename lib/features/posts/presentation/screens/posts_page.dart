import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/screens/add_update_posts_page.dart';
import 'package:posts_app/features/posts/presentation/widget/display_message_widget.dart';
import 'package:posts_app/features/posts/presentation/widget/list_of_posts_widget.dart';

import '../../../../core/widgets/loading_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: MyPageBody(),
    );
  }

  AppBar _buildAppBar(context) => AppBar(
        title: const Text('Fake Posts'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => AddUpdatePostsPage(isUpdate: false)));
              },
              icon: const Icon(Icons.add_box_outlined)),
        ],
      );
}

class MyPageBody extends StatelessWidget {
  const MyPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: ListOfPostsWidget(posts: state.posts));
        } else if (state is ErrorPostsState) {
          return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: DisplayMessageWidget(message: state.message));
        }
        return LoadingWidget();
      },
    );
  }
}

Future<void> _onRefresh(context) async {
  BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
}
