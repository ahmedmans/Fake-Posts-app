import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failure.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class DeletePostUseCase {
  final PostsRepository postsRepository;

  DeletePostUseCase(this.postsRepository);

  Future<Either<Failure, Unit>> call(int id) async {
    return postsRepository.deletePost(id);
  }
}
