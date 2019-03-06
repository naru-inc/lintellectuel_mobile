import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/post_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lintellectuel_mobile/models/category.dart';
import 'package:lintellectuel_mobile/models/post.dart';

class Carroussel extends StatefulWidget {
  final Category category;
  final List<Post> posts;

  const Carroussel({Key key, @required this.category, this.posts})
      : assert(category != null);

  @override
  _CarrousselState createState() => _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  PageController controller;
  int currentpage = 0;
/* 
  Future<String> _getPosts() async {
    print("fetching posts data");
    final response = await http.get(
        "https://www.lintellectuel.com/wp-json/wp/v2/posts?categories="+widget.category.id.toString()+"&_embed=true");

    if (response.statusCode == 200) {
      posts = (json.decode(response.body) as List)
          .map((data) => new Post.fromJson(data))
          .toList();
    } else {
      throw Exception('Failed to load photos');
    }

    setState(() {
      posts = posts;
    });
    return "success!";
  } */

  @override
  void initState() {
    super.initState();
    controller = new PageController(
        initialPage: currentpage,
        keepPage: false,
        viewportFraction: 0.9 //size of the current page (card)
        );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 500,
      child: new PageView.builder(
          controller: controller,
          itemCount: widget.posts.length,
          itemBuilder: (context, index) => builder(index)),
    );
  }

  builder(int index) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        double shadowVal = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * .3)).clamp(0.0, 1.0);
          shadowVal = controller.page - index;
          shadowVal = (1 - (shadowVal.abs() * .7)).clamp(0.0, 1.0);
        }

        return PostItem(
          datePublished: widget.posts[index].datePublished,
          title: widget.posts[index].htmlTitle,
          excerpt: widget.posts[index].excerpt,
          imageUrl: widget.posts[index].imageUrl.toString(),
          content: widget.posts[index].htmlContent,
          authorName: widget.posts[index].authorName,
          value: value,
          shadowVal: shadowVal,
        );
      },
    );
  }
}
