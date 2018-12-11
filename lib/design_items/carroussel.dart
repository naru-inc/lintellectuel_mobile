import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/post_item.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lintellectuel_mobile/models/post.dart';

class Carroussel extends StatefulWidget {
  @override
  _CarrousselState createState() => _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  PageController controller;
  int currentpage = 0;
  List<Post> posts = List();

  Future<String> _getPosts() async {
    final response = await http.get(
        "https://www.lintellectuel.com/wp-json/wp/v2/posts?categories=2&_embed=true");

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
  }

  final String apiUrl =
      "https://www.lintellectuel.com/wp-json/wp/v2/posts?categories=2";

  @override
  void initState() {
    _getPosts();
    super.initState();
    controller = new PageController(
        initialPage: currentpage,
        keepPage: false,
        viewportFraction: 0.7 //size of the current page (card)
        );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          flexibleSpace: Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image(
                      image: NetworkImage(
                          'https://www.lintellectuel.com/storage/2018/09/Untitled-1.png')))

              /* child: Image(image: NetworkImage('https://www.lintellectuel.com/storage/2018/09/Untitled-1.png'),) */),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      body: new Container(
          child: new PageView.builder(
              controller: controller,
              itemCount: posts.length,
              itemBuilder: (context, index) => builder(index)),
      ),
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
          title: posts[index].htmlTitle,
          excerpt: posts[index].excerpt,
          imageUrl: posts[index].imageUrl.toString(),
          content: posts[index].htmlContent,
          value: value,
          shadowVal: shadowVal,
        );
      },
    );
  }
}
