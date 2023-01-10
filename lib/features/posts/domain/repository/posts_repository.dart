import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostsEntity>>> getAllPosts();
  Future<Either<Failure, Unit>> addPost(PostsEntity post);
  Future<Either<Failure, Unit>> updatePost(PostsEntity post);
  Future<Either<Failure, Unit>> deletePost(int id);
}
