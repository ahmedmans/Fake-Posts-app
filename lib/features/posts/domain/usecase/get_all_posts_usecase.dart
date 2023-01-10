import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class GetAllPostsUseCase {
  final PostsRepository postsRepository;

  GetAllPostsUseCase(this.postsRepository);

  Future<Either<Failure, List<PostsEntity>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
