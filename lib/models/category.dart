import 'package:html_unescape/html_unescape.dart';

class Category {
  int id;
  int count;
  String name;
  String description;


  Category(
      {this.id,
        this.count,
        this.name,
        this.description
    });

  factory Category.fromJson(Map<String, dynamic> json) {
    var unescape = new HtmlUnescape();


    return new Category(
        id: json['id'],
      count: json['count'],
      name: unescape.convert(json['name']),
      description:
            unescape.convert(json['description']),
        );
  }
}
