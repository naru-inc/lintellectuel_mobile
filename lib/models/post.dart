
import 'package:html_unescape/html_unescape.dart';
import 'package:html/parser.dart' show parse;

class Post {
  int id;
  DateTime datePublished;
  String htmlTitle;
  String excerpt;
  String htmlContent;
  String authorId;
  String imageUrl;
  String thumbnail;
  List<int> categoriesId;

  Post(
      {this.id,
      this.datePublished,
      this.htmlTitle,
      this.excerpt,
      this.htmlContent,
      this.authorId,
      this.imageUrl,
      this.thumbnail,
      this.categoriesId});

  factory Post.fromJson(Map<String, dynamic> json) {
    var unescape = new HtmlUnescape();
    var document = parse(unescape.convert(json['excerpt']['rendered']));
    print(document.text);

    return new Post(
        id: json['id'],
        datePublished: DateTime.parse(json['date']),
        htmlTitle: unescape.convert(json['title']['rendered']),
        excerpt:
            unescape.convert(json['excerpt']['rendered']).substring(0, 150) +
                " ...",
        htmlContent: json['content']['rendered'],
        imageUrl: json['_embedded']['wp:featuredmedia'][0]['media_details']
            ['sizes']['medium']['source_url']);
  }
}
