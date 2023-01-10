import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/core/strings/failure_strings.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/domain/usecase/get_all_posts_usecase.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;
  PostsBloc({required this.getAllPostsUseCase}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPostsEvent) {
        final allPosts = await getAllPostsUseCase();
        emit(LoadingPostsState());
        emit(_postsState(allPosts));
      } else if (event is RefreshPostsEvent) {
        final allPosts = await getAllPostsUseCase();
        emit(LoadingPostsState());
        emit(_postsState(allPosts));
      }
    });
  }

  PostsState _postsState(Either<Failure, List<PostsEntity>> either) {
    return either.fold(
        (failure) => ErrorPostsState(message: _failureMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _failureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerException:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheException:
        return EMPTY_CACHE_FAILURE_MESSAGE;

      case OfflineException:
        return OFFLINE_FAILURE_MESSAGE;

      default:
        return 'Unexpected Error, Please Try Again Later';
    }
  }
}
