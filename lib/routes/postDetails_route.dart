import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PostDetailRoute extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final String authorName;
  final  DateTime datePublished;

  const PostDetailRoute({Key key, this.title, this.content, this.imageUrl, this.authorName, this.datePublished})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theCard = new ListView(shrinkWrap: true, children: <Widget>[
      Center(
          child: new SizedBox(
        child:
            //height: 500,
            Padding(
                padding: EdgeInsets.all(10.0),
                child: new Card(
                  color: Colors.white,
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(4.0),
                  child: Container(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new SizedBox(
                              child: Container(
                            width: double.infinity,
                            color: Colors.black,
                            child: Image(
                                image: new NetworkImage(imageUrl),
                                fit: BoxFit.fitWidth),
                          )),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, left: 20.0, right: 20.0),
                              child: Text(
                                this.title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.all(20.0),
   
                               child: Html(
                                  data: this.content,
                                  defaultTextStyle: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                  customRender: (node, children) {
                                    if (node is dom.Element) {  
                                      switch (node.localName) {
                                        case "img":
                            return Image(
                                image: new NetworkImage(node.attributes['src']),width: double.infinity,);
              
                                      }
                                    }
                                  }) )
                        ]),
                  ),
                )),
      )),
    ]);

    return theCard;
  }
}
