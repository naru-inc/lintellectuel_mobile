import 'package:flutter/material.dart';
import 'package:lintellectuel_mobile/main_route/article_item.dart';

class Carroussel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CarrousselState();
}

class _CarrousselState extends State<Carroussel> {
  PageController controller;
  int currentpage = 0;

  @override
  void initState() {
    super.initState();
    controller = new PageController(
        initialPage: currentpage,
        keepPage: false,
        viewportFraction: 0.8 //size of the current page (card)
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
      body: new Container(
        child: new Container(
          child: new PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentpage = value;
                  print(value);
                });
              },
              controller: controller,
              itemBuilder: (context, index) => builder(index)),
        ),
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

        return ArticleItem(
          title: 'Welcome to l\'intellectuel.com',
          excerpt:'Welcome to l\'intellectuel.com Welcome to l\'intellectuel.com Welcome to l\'intellectuel.com' ,
          imageUrl: 'https://www.lintellectuel.com/storage/2018/10/15449217.jpg',
          value: value,
          shadowVal: shadowVal,
        );
      },
    );


  }
}
