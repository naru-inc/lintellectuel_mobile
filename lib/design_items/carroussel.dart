import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/post_item.dart';
import 'package:http/http.dart' as http;

import 'package:lintellectuel_mobile/models/category.dart';
import 'package:lintellectuel_mobile/models/post.dart';

class Carroussel extends StatefulWidget {
  final Category category;
  final List<Post> posts;
  final int totalPages;

  const Carroussel({Key key, @required this.category, this.posts, this.totalPages})
      : assert(category != null);

  @override
  _CarrousselState createState() => _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  PageController controller;
  int currentpage = 1;
  bool progress = false;

   Future<List<Post>> _getPosts() async {
     setState(() {
            progress = true;

     });
    print("fetching posts data 2");
    final response = await http.get(
        "https://www.lintellectuel.com/wp-json/wp/v2/posts?categories="+widget.category.id.toString()+"&_embed=true&page="+(currentpage+1).toString()+"&per_page=5");
        setState(() {
        widget.posts.addAll((json.decode(response.body) as List)
                .map((data) => new Post.fromJson(data))
                .toList());  

        
      });
      progress=false;
      print("data fetched successefully");
  
    return null;
  }


  @override
  void initState() {
    super.initState();
    currentpage = 1;
    controller = new PageController(
        initialPage: currentpage,
        keepPage: false,
        viewportFraction: 0.9 //size of the current page (card)
        );

          controller.addListener(_scrollListener);
  }

  _scrollListener() {
    print(controller.position.maxScrollExtent);

 if (controller.offset >= controller.position.maxScrollExtent ) {
   
      setState(() {
        print("reach the end");
        print(widget.totalPages);
        print(currentpage);
        if(currentpage<widget.totalPages)
        {
        _getPosts();
        currentpage=currentpage+1;
        }

      });
    }
    if (controller.offset <= controller.position.minScrollExtent &&
        !controller.position.outOfRange) {
      setState(() {
        print("reach the beh");

      });
    }
 }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


Widget _progressCarou(){
  if(progress==true){
   
    return  Stack(children: <Widget>[
      BackdropFilter(
                   filter: new ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                   child: new Container(
                     decoration: new BoxDecoration(
                         color: Colors.white.withOpacity(0.5)),
                   ),
                 ),
                 Center(
                   child: CircularProgressIndicator(),
                 )
                 

    ]);

    
  }else{
    return  Container();
  }
}


  @override
  Widget build(BuildContext context) {
     
 
    return      Stack(
  children: <Widget>[

    

    new Container(
      height: 500,
      child : new PageView.builder(
          controller: controller,
          itemCount: widget.posts.length,
          itemBuilder: (context, index) => builder(index))
    ),
        _progressCarou(),


  ]);
  
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
