import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/backdrop.dart';
import 'package:lintellectuel_mobile/routes/home_route2.dart';
import 'routes/home_route.dart';
import 'models/category.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lintellectuel_mobile/models/category.dart';
import 'package:lintellectuel_mobile/models/post.dart';

void main() {
  runApp(LintellectuelApp());
}


class LintellectuelApp extends StatefulWidget {
  @override
  _LintellectuelAppState createState() => _LintellectuelAppState();
}
/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class _LintellectuelAppState extends State<LintellectuelApp> {
  Category _currentCategory = Category(id: 2,name:"À La Une" );
  List<Post> posts = List();
  int totalPages = 1;

  @override
  Widget build(BuildContext context) {
    //_getPosts(Category(id: 2,name:"À La Une" ));
    // Here we can change the data that is passed to home Route1
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'L\'intellectuel',
        home: new  Backdrop(
          currentCategory: _currentCategory,
          frontLayer: HomeRoute(category : _currentCategory, posts : posts, getPosts: _getPosts(_currentCategory),totalPages:totalPages),
          backLayer: HomeRoute2(onCategoryTap: _onCategoryTap),
        ),
    );
  }

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });

  }

    Future<List<Post>> _getPosts(Category category) async {
    print("fetching posts data");
    final response = await http.get(
        "https://www.lintellectuel.com/wp-json/wp/v2/posts?categories="+category.id.toString()+"&_embed=true&page=1&per_page=5&hide_empty=true");

        var sbewlou = (response.headers);
        totalPages = int.parse(sbewlou['x-wp-totalpages']);
        print(totalPages);

      posts = (json.decode(response.body) as List)
          .map((data) => new Post.fromJson(data))
          .toList();
  
  
    return posts;
  }


}
