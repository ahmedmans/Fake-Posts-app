import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/theme_app.dart';
import 'package:posts_app/core/util/snack_bar_msg.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/post_options_bloc/post_options_bloc.dart';
import 'package:posts_app/features/posts/presentation/screens/posts_page.dart';
import 'package:posts_app/features/posts/presentation/widget/add_update_post_form.dart';

class AddUpdatePostsPage extends StatelessWidget {
  final PostsEntity? posts;
  final bool isUpdate;
  const AddUpdatePostsPage({
    super.key,
    this.posts,
    required this.isUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? "Edit Post" : "New Post",
        ),
      ),
      body: BlocConsumer<PostOptionsBloc, PostOptionsState>(
        builder: (context, state) {
          if (state is LoadingPostOptionsState) {
            return LoadingWidget();
          }
          return AddUpdatePostForm(
            isUpdate: isUpdate,
            posts: posts,
          );
        },
        listener: (context, state) {
          if (state is MessagePostOptionsState) {
            SnackBarMSG().successMSG(
              message: state.message,
              context: context,
            );
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => PostsPage()),
                (route) => false);
          } else if (state is ErorrPostOptionsState) {
            SnackBarMSG().errorMSG(
              message: state.message,
              context: context,
            );
          }
        },
      ),
    );
  }
}
