part of 'post_options_bloc.dart';

abstract class PostOptionsEvent extends Equatable {
  const PostOptionsEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends PostOptionsEvent {
  final PostsEntity postsEntity;

  const AddPostEvent({required this.postsEntity});
  @override
  List<Object> get props => [postsEntity];
}

class UpdatePostEvent extends PostOptionsEvent {
  final PostsEntity postsEntity;

  const UpdatePostEvent({required this.postsEntity});
  @override
  List<Object> get props => [postsEntity];
}

class DeletePostEvent extends PostOptionsEvent {
  final int postId;

  const DeletePostEvent({required this.postId});
  @override
  List<Object> get props => [postId];
}
