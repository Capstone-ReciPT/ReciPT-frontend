import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class UploadRecipe{
  final File thumbnail;
  final String title;
  final String comment;
  final String category;
  final List<String> ingredients;
  final List<String> recipe;
  final List<dynamic> images;

  UploadRecipe(this.thumbnail, this.title, this.comment, this.category,
      this.ingredients, this.recipe, this.images);

  @override
  String toString() {
    return 'UploadRecipe{thumbnail: $thumbnail, title: $title, comment: $comment, category: $category, ingredients: $ingredients, recipe: $recipe, images: $images}';
  }
}
Future<void> fetchUploadRecipe(thumbnail,title,comment,category,ingredients,recipe,images) async{
  var recipeInstance = UploadRecipe(thumbnail, title, comment, category, ingredients, recipe, images);
  print(recipeInstance);
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  // final response = await dio.post('$baseUrl/api/register/save',
  //   data: {food},
  //   options: Options(
  //     headers: {
  //       'Content-Type': 'text/plain',
  //       'Authorization': jwt,
  //     }, // Content-Type 헤더 설정
  //   ),
  // );
}


