import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/features/posts/data/model/posts_model.dart';
import 'package:http/http.dart' as http;

abstract class BasePostsRemoteDataSource {
  Future<List<PostsModel>> getAllPosts();
  Future<Unit> addPost(PostsModel post);
  Future<Unit> updatePost(PostsModel post);
  Future<Unit> deletePost(int id);
}

const String Base_url = 'https://jsonplaceholder.typicode.com';

class PostsRemoteDataSource implements BasePostsRemoteDataSource {
  final http.Client clinet;

  PostsRemoteDataSource({required this.clinet});

  @override
  Future<Unit> addPost(PostsModel post) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final respons = await clinet.post(
      Uri.parse('$Base_url/posts/'),
      body: body,
    );

    if (respons.statusCode == 201) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int id) async {
    final respons = await clinet.delete(
      Uri.parse('$Base_url/posts/${id.toString()}'),
      headers: {"Content-Type": "application/json"},
    );
    if (respons.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostsModel>> getAllPosts() async {
    final respons = await clinet.get(
      Uri.parse('$Base_url/posts/'),
      headers: {'Content-Type': 'application/json'},
    );
    if (respons.statusCode == 200) {
      final List decodeJson = jsonDecode(respons.body);
      final List<PostsModel> postsmodel =
          decodeJson.map((jsonPost) => PostsModel.fromJson(jsonPost)).toList();

      return postsmodel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostsModel post) async {
    final postId = post.id.toString();
    final body = {
      'title': post.title,
      'body': post.body,
    };

    final respons = await clinet.patch(
      Uri.parse('$Base_url/posts/$postId'),
      body: body,
    );
    if (respons.statusCode == 200) {
      return unit;
    } else {
      throw ServerException();
    }
  }
}
