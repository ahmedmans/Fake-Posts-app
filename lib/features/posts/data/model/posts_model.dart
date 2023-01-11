import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';

class PostsModel extends PostsEntity {
  const PostsModel({
    super.id,
    required super.title,
    required super.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
      };
}
