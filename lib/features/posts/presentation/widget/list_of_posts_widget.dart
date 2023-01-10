import 'package:flutter/material.dart';
import 'package:posts_app/core/theme_app.dart';
import 'package:posts_app/features/posts/domain/entities/posts_entity.dart';

class ListOfPostsWidget extends StatelessWidget {
  const ListOfPostsWidget({super.key, required this.posts});
  final List<PostsEntity> posts;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(
        height: size.height * 0.02,
      ),
      itemBuilder: (context, index) => Container(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: primaryColor,
                width: 2,
              )),
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: size.width * 0.12,
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      posts[index].id.toString(),
                      style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    // height: size.height * 0.08,
                    width: size.width * 0.72,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      posts[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Text(
                posts[index].body,
                style: TextStyle(
                  fontSize: 15,
                  color: primaryColor.withOpacity(0.5),
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
      itemCount: posts.length,
    );
  }
}
