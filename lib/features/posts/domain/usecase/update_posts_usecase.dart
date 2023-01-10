import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class UpdatePostsUseCase {
  final PostsRepository postsRepository;

  UpdatePostsUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(PostsEntity post) async {
    return await postsRepository.updatePost(post);
  }
}
