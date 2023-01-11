import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/strings/failure_strings.dart';
import 'package:posts_app/core/strings/succss_message.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/domain/usecase/add_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecase/delete_post_usecase.dart';
import 'package:posts_app/features/posts/domain/usecase/update_posts_usecase.dart';

part 'post_options_event.dart';
part 'post_options_state.dart';

class PostOptionsBloc extends Bloc<PostOptionsEvent, PostOptionsState> {
  AddPostUseCase addPostUseCase;
  UpdatePostsUseCase updatePostsUseCase;
  DeletePostUseCase deletePostUseCase;
  PostOptionsBloc({
    required this.addPostUseCase,
    required this.updatePostsUseCase,
    required this.deletePostUseCase,
  }) : super(PostOptionsInitial()) {
    on<PostOptionsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingPostOptionsState());
        final optionsState = await addPostUseCase(event.postsEntity);
        emit(postOptionsState(optionsState, ADD_SUCCESS_MESSAGE));
      } else if (event is UpdatePostEvent) {
        emit(LoadingPostOptionsState());
        final optionsState = await updatePostsUseCase(event.postsEntity);
        emit(postOptionsState(optionsState, UPDATE_SUCCESS_MESSAGE));
      } else if (event is DeletePostEvent) {
        emit(LoadingPostOptionsState());
        final optionsState = await deletePostUseCase(event.postId);
        emit(postOptionsState(optionsState, DELETE_SUCCESS_MESSAGE));
      }
    });
  }

  PostOptionsState postOptionsState(
      Either<Failure, Unit> optionsEither, String message) {
    return optionsEither.fold(
        (failure) => ErorrPostOptionsState(
              message: _failureMessage(failure),
            ),
        (_) => MessagePostOptionsState(message: message));
  }

  String _failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'Unexpected Error, Please Try Again Later';
    }
  }
}
