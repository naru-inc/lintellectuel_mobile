import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lintellectuel_mobile/models/post.dart';
import 'package:flutter_html/flutter_html.dart';

class PostListView extends StatefulWidget {
  @override
  _PostListViewState createState() => _PostListViewState();


}
class _PostListViewState extends State<PostListView>{
  List<Post> posts = List();

  Future<String> _getPosts() async {
    final response = await http.get(
        "https://www.lintellectuel.com/wp-json/wp/v2/posts?_embed=true");

    if (response.statusCode == 200) {
      posts = (json.decode(response.body) as List)
          .map((data) => new Post.fromJson(data))
          .toList();
      setState(() {
        posts = posts;
      });
    } else {
      throw Exception('Failed to load photos');
    }


    return "success!";
  }


  @override
  void initState() {
    _getPosts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return new Container(

    child:
    ListView.builder(
      physics: ClampingScrollPhysics(),

      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[

                new SizedBox(
                  height: 250,
                  child :  InkWell(
                    child: new Card(
                      color: Colors.transparent,
                      elevation:  5,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                               10.0)),
                      margin: const EdgeInsets.all(4.0),
                      child: Container(
                        child: Center(
                          child: new Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(
                                        left: 20.0,
                                        right:  20.0),
                                    child: Text(
                                      posts[index].htmlTitle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize:24.0,
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.all(
                                        14.0),
                                    child: Html(
                                      data: posts[index].excerpt,
                                      defaultTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize:18.0),
                                    ))
                              ]),
                        ),
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.5),
                                    BlendMode.darken),
                                image: new NetworkImage(posts[index].imageUrl))),
                      ),
                    ),
                  ),
                )

              ],

            )
        );
      },
    ))
    ;
  }

}