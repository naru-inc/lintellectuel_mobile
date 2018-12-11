import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PostDetailRoute extends StatelessWidget{
  final String title;
  final String content;
  final String imageUrl;

  const PostDetailRoute({Key key, this.title, this.content, this.imageUrl}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    

    final theCard = 
     new ListView(
      
      shrinkWrap: true,
              children: <Widget>[ Center(
      child: new SizedBox( child :
        //height: 500,
        Padding(
                        padding: EdgeInsets.all(15.0),
        child: new Card(
          color: Colors.white,
          elevation: 2,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)),
          margin: const EdgeInsets.all(4.0),
          child: Container(
    child: Center(
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Image(image: new NetworkImage(imageUrl)),
                    Padding(
                        padding: EdgeInsets.only(
                          top: 30.0,
                            left: 20.0,
                            right: 20.0),
                        child: Text(
                          this.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:  35.0,
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.all(
                            20.0),
                        child: Html(
                          data: this.content,
                          defaultTextStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0),
                        ))
                  ]),
            ),

            )
          ),
        )
        
      ),
    )
              ]
    );
    

    return theCard;
  }


}