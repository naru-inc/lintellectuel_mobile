import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/carroussel.dart';
import 'package:lintellectuel_mobile/design_items/post_listview.dart';

class HomeRoute2 extends StatelessWidget{
  const HomeRoute2();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(shrinkWrap: true, children: <Widget>[

      Container(
        color: Colors.red,

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30,left: 10),
              child:
              Text('Catégories',style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w300 ),)
            ),
            PostListView(),
          ],
        ),
      ),
    ]);
  }


}