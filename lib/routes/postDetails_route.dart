import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:timeago/timeago.dart' as timeago;


class PostDetailRoute extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final String authorName;
  final DateTime datePublished;

  const PostDetailRoute({Key key, this.title, this.content, this.imageUrl, this.authorName, this.datePublished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('fr', timeago.FrMessages());
    final theCard = new ListView(shrinkWrap: true, children: <Widget>[
      Center(
          child: new SizedBox(
        child:
            //height: 500,
            Padding(
                padding: EdgeInsets.all(20.0),
                child: new Card(
                  color: Colors.white,
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  margin: const EdgeInsets.all(4.0),
                  child: Container(
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          new SizedBox(
                              child: Container(
                                  width: double.infinity,
                                  color: Colors.black,
                                  child: FadeInImage.assetNetwork(
                                      placeholder: 'images/loading_12.gif',
                                      image: imageUrl,
                                      fit: BoxFit.fitWidth))),

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
                            padding: EdgeInsets.only(top:5, left: 20, right:20, bottom: 5 ),
                            child: Text(timeago.format(datePublished,locale: 'fr'),style: TextStyle(color: Colors.black26),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20, right:20, bottom: 20 ),
                            child: Text("Par " + this.authorName, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black54)),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 10),
                              child: Html(
                                  data: this.content,
                                  defaultTextStyle: TextStyle(
                                      color: Colors.black, fontSize: 14.0),
                                  customRender: (node, children) {
                                    if (node is dom.Element) {
                                      switch (node.localName) {
                                        case "img":
                                          return FadeInImage.assetNetwork(
                                            placeholder:
                                                'images/loading_12.gif',
                                            image: node.attributes['src'],
                                          );


                                      }
                                    }
                                  }))
                        ]),
                  ),
                )),
      )),
    ]);

    return theCard;
  }
}
