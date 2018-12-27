import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lintellectuel_mobile/models/category.dart';
import 'package:lintellectuel_mobile/models/category_repository.dart';
import 'package:lintellectuel_mobile/models/post.dart';
import 'package:flutter_html/flutter_html.dart';

class PostListView extends StatefulWidget {
  @override
  _PostListViewState createState() => _PostListViewState();


}
class _PostListViewState extends State<PostListView>{
  List<Category> categories = List();

  Future<String> _getPosts() async {
    final response = await CategoryRepository.getCategories();


      setState(() {
        categories = response;
      });



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
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: <Widget>[

                new SizedBox(
                  height: 250,
                  child :  InkWell(
                    child: new Card(
                      color: Colors.white,
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
                                      categories[index].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:24.0,
                                      ),
                                    )),

                              ]),
                        ),

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