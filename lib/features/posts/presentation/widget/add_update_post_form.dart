import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/presentation/bloc/post_options_bloc/post_options_bloc.dart';
import 'package:posts_app/features/posts/presentation/widget/custom_form_field.dart';

class AddUpdatePostForm extends StatefulWidget {
  final bool isUpdate;
  final PostsEntity? posts;
  const AddUpdatePostForm({super.key, required this.isUpdate, this.posts});

  @override
  State<AddUpdatePostForm> createState() => _AddUpdatePostFormState();
}

class _AddUpdatePostFormState extends State<AddUpdatePostForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleContrller = TextEditingController();
  final TextEditingController _bodyContrller = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleContrller.text = widget.posts!.title;
      _bodyContrller.text = widget.posts!.body;
    }
    super.initState();
  }

  void validAddUpdatePosts() {
    final valid = _formKey.currentState!.validate();

    if (valid) {
      final post = PostsEntity(
        id: widget.isUpdate ? widget.posts!.id : null,
        title: _titleContrller.text,
        body: _bodyContrller.text,
      );
      if (widget.isUpdate) {
        BlocProvider.of<PostOptionsBloc>(context)
            .add(UpdatePostEvent(postsEntity: post));
      } else {
        BlocProvider.of<PostOptionsBloc>(context)
            .add(AddPostEvent(postsEntity: post));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CustomFormField(
              textContrller: _titleContrller,
              valText: "Title Can't be Empty",
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomFormField(
              textContrller: _bodyContrller,
              valText: "Post Can't be Empty",
              isBody: true,
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.02),
              width: size.width,
              height: size.height * 0.06,
              child: ElevatedButton.icon(
                onPressed: validAddUpdatePosts,
                icon: widget.isUpdate
                    ? Icon(Icons.edit_note_sharp)
                    : Icon(Icons.post_add),
                label: Text(widget.isUpdate ? "Edit Post" : "Post"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
