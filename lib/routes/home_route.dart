import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/design_items/carroussel.dart';
import 'package:lintellectuel_mobile/design_items/post_listview.dart';
import 'package:lintellectuel_mobile/models/category.dart';

class HomeRoute extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child:
    Center(
        child:Carroussel()
    )
      );

  }


}