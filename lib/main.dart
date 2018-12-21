import 'package:flutter/material.dart';
import 'design_items/carroussel.dart';
import 'routes/home_route.dart';

void main() {
  runApp(LintellectuelApp());
}

/// This widget is the root of our application.
/// Currently, we just show one widget in our app.
class LintellectuelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: imp(lement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'L\'intellectuel',
        home: new Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                flexibleSpace: Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child:
                            Image(image: AssetImage('images/main_logo_b.png')))

                    /* child: Image(image: NetworkImage('https://www.lintellectuel.com/storage/2018/09/Untitled-1.png'),) */),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            body: HomeRoute()
    ));
  }
}


