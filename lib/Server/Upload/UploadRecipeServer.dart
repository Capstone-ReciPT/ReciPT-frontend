import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:http/http.dart' as http;

class UploadRecipe{
  final XFile thumbnail;
  final String foodName;
  final String comment;
  final String category;
  final List<String> ingredients;
  final List<String> recipe;
  final List<dynamic> images;

  UploadRecipe(this.thumbnail, this.foodName, this.comment, this.category,
      this.ingredients, this.recipe, this.images);

  @override
  String toString() {
    return 'UploadRecipe{thumbnail: $thumbnail, foodName: $foodName, comment: $comment, category: $category, ingredients: $ingredients, recipe: $recipe, images: $images}';
  }
}
Future<bool> fetchUploadRecipe(
    XFile thumbnail,
    String foodName,
    String comment,
    String category,
    List<String> ingredients,
    List<String> recipe,
    List<dynamic> images
    ) async{

  Dio dio = Dio();

  String? baseUrl = dotenv.env['BASE_URL'];
  var jwt = await getJwt();
  print(jwt);

  final thumbnailBinary = MultipartFile.fromFileSync(thumbnail.path,  contentType: MediaType("image", "jpg"));
  final List<MultipartFile> files = images.map((img) => MultipartFile.fromFileSync(img.path,  contentType: MediaType("image", "jpg"))).toList();

  String ingredientsString = ingredients.join(', ');
  print(ingredientsString);
  String recipeString = recipe.asMap().entries.map((entry) {
    int idx = entry.key + 1;
    String value = entry.value;
    return '$idx. $value.';
  }).join(' ');(', ');

  print(recipeString);

  FormData formData = FormData.fromMap({
    'thumbnail': thumbnailBinary,
    'foodName': foodName,
    'comment': comment,
    'category': category,
    'ingredients': ingredientsString,
    'contexts': recipeString,
    'images': files,
  });

  final response = await dio.post(
    '$baseUrl/api/register/save/typing',
    data: formData,
    options: Options(
        headers: {
          'accesToken': jwt,
          'Authorization': 'Bearer $jwt',
        },
        contentType: 'multipart/form-data'
    ),
  );
  print(response);
  if(response.data['code'] == 500){
    return false;
  }
  else if (response.data['code'] == null){
    return true;
  } else{
    return false;
  }
}
Future<Uint8List> readFileAsBytes(File file) async {
  Uint8List uint8list;
  try {
    uint8list = await file.readAsBytes();
    return uint8list;
  } catch (e) {
    // 파일을 읽는 중에 오류가 발생할 수 있으므로 오류 처리가 필요합니다.
    print(e.toString());
    return Uint8List(0); // 빈 Uint8List 반환 또는 오류 처리 방식을 선택하세요.
  }
}


