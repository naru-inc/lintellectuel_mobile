import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lintellectuel_mobile/models/category.dart';
import 'package:lintellectuel_mobile/models/category_repository.dart';
import 'package:lintellectuel_mobile/models/post.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:math';

class CategoriesListView extends StatefulWidget {
  @override
  _CategoriesListViewState createState() => _CategoriesListViewState();
}

class _CategoriesListViewState extends State<CategoriesListView> {
  List<Category> categories = [];
  ScrollController _scrollController = new ScrollController();
  bool isPerformingRequest = false;

  _getCategories() async {
    if (!isPerformingRequest) {
      setState(() {
        isPerformingRequest = true;
      });
    }

    final resp = await CategoryRepository.getCategories();
    setState(() {
      categories.addAll(resp);
      isPerformingRequest = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCategories();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getCategories();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double generateRandom(){
    var rng=new Random();
    return rng.nextInt(150)+80.0;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Stack(
          children: <Widget>[
          Positioned(
          left: this.generateRandom(),

child:
          Container(
              child: Container(
                  child: Center(
                child: Text(
                  categories[index].count.toString(),
                  style: TextStyle(
                      color: Colors.white30,

                      fontSize: 45,
                      fontWeight: FontWeight.w700),
                ),
              )),
            ),
          ),

            Container(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Center(
                child: Text(
                  categories[index].name.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              )),
            ),
          ],
        );
      },
    ));
  }
}
