import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class AddPostUseCase {
  final PostsRepository postsRepository;

  AddPostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(PostsEntity post) async {
    return await postsRepository.addPost(post);
  }
}
