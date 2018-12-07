import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostItem extends StatelessWidget {
  final String title;
  final String excerpt;
  final String imageUrl;
  final double value;
  final double shadowVal;

  const PostItem({Key key, this.title, this.excerpt, this.imageUrl, this.value, this.shadowVal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: new SizedBox(
            height: Curves.easeOut.transform(value) * 450,
            width: Curves.easeOut.transform(value) * 350,
            child: new Card(
              color: Colors.transparent,
              elevation: Curves.easeOut.transform(shadowVal) * 10,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Curves.easeOut.transform(value) *10.0)),
              margin: const EdgeInsets.all(4.0),
              child: Container(
                child: Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: Curves.easeOut.transform(value) *20.0, right: Curves.easeOut.transform(value) *20.0),
                            child: Text(
                              this.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Curves.easeOut.transform(value) *35.0,
                                
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.all(Curves.easeOut.transform(value) *20.0),
                          child: Html(data: this.excerpt, defaultTextStyle: TextStyle(color: Colors.white, fontSize: Curves.easeOut.transform(value) *18.0),)
  
                        )
                      ]),
                ),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(shadowVal * 0.5),
                            BlendMode.darken),
                        image: new NetworkImage(
                            this.imageUrl))),
              ),
            ),
          ),
        );
  }

}