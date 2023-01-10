import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/features/posts/data/model/posts_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BasePostsLocleDataSource {
  Future<List<PostsModel>> getAllCachedPosts();
  Future<Unit> cachePosts(List<PostsModel> postsModel);
}

const String CACHE_POSTS = 'CACHE_POSTS';

class PostsLocleDataSource implements BasePostsLocleDataSource {
  final SharedPreferences sharedPreferences;

  PostsLocleDataSource({required this.sharedPreferences});
  @override
  Future<Unit> cachePosts(List<PostsModel> postsModel) async {
    List postModelToJson = postsModel.map((posts) => posts.toJson()).toList();
    await sharedPreferences.setString(
        CACHE_POSTS, json.encode(postModelToJson));
    return unit;
  }

  @override
  Future<List<PostsModel>> getAllCachedPosts() async {
    final jsonString = sharedPreferences.getString(CACHE_POSTS);
    if (jsonString != null) {
      List decodeJsonData = await json.decode(jsonString);

      List<PostsModel> postsModel = decodeJsonData
          .map<PostsModel>((postModel) => PostsModel.fromJson(postModel))
          .toList();
      return postsModel;
    } else {
      throw EmptyCacheException();
    }
  }
}
