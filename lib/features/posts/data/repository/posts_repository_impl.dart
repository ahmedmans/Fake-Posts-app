import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/network/internet_connection_status.dart';
import 'package:posts_app/features/posts/data/locale_datasource/posts_locale_datasource.dart';
import 'package:posts_app/features/posts/data/remote_datasource/posts_remote_data_source.dart';
import 'package:posts_app/features/posts/data/model/posts_model.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

typedef AddOrDeleteOrUpdate = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final BasePostsLocleDataSource basePostsLocleDataSource;
  final BasePostsRemoteDataSource basePostsRemoteDataSource;
  final BaseInternetConnectionStatus baseInternetConnectionStatus;

  PostsRepositoryImpl({
    required this.basePostsLocleDataSource,
    required this.basePostsRemoteDataSource,
    required this.baseInternetConnectionStatus,
  });

  @override
  Future<Either<Failure, List<PostsEntity>>> getAllPosts() async {
    if (await baseInternetConnectionStatus.isConnected) {
      try {
        final remotePosts = await basePostsRemoteDataSource.getAllPosts();
        basePostsLocleDataSource.cachePosts(remotePosts);

        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final loclePosts = await basePostsLocleDataSource.getAllCachedPosts();

        return Right(loclePosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostsEntity post) async {
    PostsModel postsModel = PostsModel(title: post.title, body: post.body);
    return await _getMessage(
        () => basePostsRemoteDataSource.updatePost(postsModel));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostsEntity post) async {
    PostsModel postsModel =
        PostsModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(
        () => basePostsRemoteDataSource.updatePost(postsModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() => basePostsRemoteDataSource.deletePost(id));
  }

  Future<Either<Failure, Unit>> _getMessage(
      AddOrDeleteOrUpdate addOrDeleteOrUpdate) async {
    if (await baseInternetConnectionStatus.isConnected) {
      try {
        // await basePostsRemoteDataSource.deletePost(id);
        await addOrDeleteOrUpdate();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
