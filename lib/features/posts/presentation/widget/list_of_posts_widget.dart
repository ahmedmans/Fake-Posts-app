import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/theme_app.dart';
import 'package:posts_app/core/util/snack_bar_msg.dart';
import 'package:posts_app/core/widgets/loading_widget.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/post_options_bloc/post_options_bloc.dart';
import 'package:posts_app/features/posts/presentation/screens/add_update_posts_page.dart';
import 'package:posts_app/features/posts/presentation/widget/delete_dialog_widget.dart';

class ListOfPostsWidget extends StatelessWidget {
  const ListOfPostsWidget({super.key, required this.posts});
  final List<PostsEntity> posts;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.builder(
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: primaryColor,
              width: 1,
            )),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: size.width * 0.12,
                  height: size.height * 0.05,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    posts[index].id.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  // height: size.height * 0.08,
                  width: size.width * 0.62,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    posts[index].title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                DeleteUpdatePopMenu(posts: posts[index]),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              posts[index].body,
              style: TextStyle(
                fontSize: 15,
                color: primaryColor.withOpacity(0.5),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
      itemCount: posts.length,
    );
  }
}

class DeleteUpdatePopMenu extends StatelessWidget {
  const DeleteUpdatePopMenu({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final PostsEntity posts;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      padding: const EdgeInsets.all(2.0),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          textStyle: TextStyle(
            color: primaryColor,
          ),
          child: const Text("Edit Post"),
        ),
        PopupMenuItem(
          value: 2,
          textStyle: TextStyle(
            color: primaryColor,
          ),
          child: const Text("Delete Post"),
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AddUpdatePostsPage(
                        isUpdate: true,
                        posts: posts,
                      )));
        } else if (value == 2) {
          _deletePost(context);
        }
      },
    );
  }

  Future<dynamic> _deletePost(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocConsumer<PostOptionsBloc, PostOptionsState>(
          builder: (context, state) {
            if (state is LoadingPostOptionsState) {
              return LoadingWidget();
            }
            return DeleteDialogWidget(
              postId: posts.id!,
            );
          },
          listener: (context, state) {
            if (state is MessagePostOptionsState) {
              SnackBarMSG()
                  .successMSG(message: state.message, context: context);
              Navigator.pop(context);
            } else if (state is ErorrPostOptionsState) {
              SnackBarMSG().errorMSG(message: state.message, context: context);
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }
}
