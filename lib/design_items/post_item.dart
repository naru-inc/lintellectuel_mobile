import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lintellectuel_mobile/routes/postDetails_route.dart';

class PostItem extends StatelessWidget {
  final String title;
  final String authorName;
  final String excerpt;
  final String imageUrl;
  final String content;
  final double value;
  final double shadowVal;
  final DateTime datePublished;


  const PostItem(
      {Key key,
      this.title,
      this.excerpt,
      this.imageUrl,
      this.value,
      this.shadowVal, this.content, this.authorName, this.datePublished})
      : super(key: key);

      void _navigateToPostDetail (BuildContext context){
        Navigator.of(context).push(
          MaterialPageRoute<Null>(
            builder: (BuildContext context){
              return Scaffold(
                          backgroundColor: Colors.black,

           appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          flexibleSpace: Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Image(
                      image: AssetImage('images/main_logo_w.png')))),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
      ),
          body: PostDetailRoute(
                title: title,
                content: content,
                imageUrl: imageUrl,
                authorName:authorName,
                datePublished:datePublished
              )
        );

               

            }

          )

        );
      }

  @override
  Widget build(BuildContext context) {

        return Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

          new SizedBox(
          height: Curves.easeOut.transform(value) * 350,
          child :  InkWell(
            onTap: ()=>_navigateToPostDetail(context),
            child: new Card(
              color: Colors.transparent,
              elevation: Curves.easeOut.transform(shadowVal) * 5,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      Curves.easeOut.transform(value) * 10.0)),
              margin: const EdgeInsets.all(4.0),
              child: Container(
                child: Center(
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: Curves.easeOut.transform(value) * 20.0,
                                right: Curves.easeOut.transform(value) * 20.0),
                            child: Text(
                              this.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Curves.easeOut.transform(value) * 24.0,
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(
                                Curves.easeOut.transform(value) * 14.0),
                            child: Html(
                              data: this.excerpt,
                              defaultTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: Curves.easeOut.transform(value) * 18.0),
                            ))
                      ]),
                ),
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(shadowVal * 0.5),
                            BlendMode.darken),
                        image: new NetworkImage(this.imageUrl))),
              ),
            ),
          ),
        )

            ],

          )
     );
  }
}
