import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/carroussel.dart';
import 'package:lintellectuel_mobile/models/category.dart';
import 'package:lintellectuel_mobile/models/post.dart';

class HomeRoute extends StatelessWidget {
  final Category category;
  final List<Post> posts;
  final Future<List<Post>> getPosts;

  const HomeRoute({Key key, @required this.category, this.posts,this.getPosts});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder <List<Post>>(
      future: getPosts,
      builder:  (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.done) {

                if(snapshot.hasError){
                  return Text("Error");
                }

        return Container(child: Center(child: Carroussel(category: category, posts:snapshot.data)));

              }
              else
                return Container(child: Center(child:CircularProgressIndicator()));


      }

    );
  }
}
