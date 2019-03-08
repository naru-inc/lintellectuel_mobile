import 'category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryRepository {


  static Future<List<Category>> getCategories() async {
    List<Category> categories = List();
    final response = await http.get(
        "https://www.lintellectuel.com/wp-json/wp/v2/categories?page=1&per_page=20&hide_empty=true&orderby=count&order=desc");

      categories = (json.decode(response.body) as List)
          .map((data) => new Category.fromJson(data))
          .toList();

  

    return categories;
  }
}