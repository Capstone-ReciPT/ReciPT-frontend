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
Future<void> fetchUploadRecipe(
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
  final Uri uri = Uri.parse('$baseUrl/api/register/save');

  final thumbnailBinary = MultipartFile.fromFileSync(thumbnail.path,  contentType: MediaType("image", "jpg"));
  final List<MultipartFile> files = images.map((img) => MultipartFile.fromFileSync(img.path,  contentType: MediaType("image", "jpg"))).toList();

  FormData formData = FormData.fromMap({
    'thumbnail': thumbnailBinary,
    'foodName': foodName,
    'comment': comment,
    'category': category,
    'ingredients': ingredients,
    'recipe': recipe,
    'images[]': files,
  });

  try {
    final response = await dio.post(
      '$baseUrl/api/register/save',
      data: formData,
      options: Options(
        headers: {
          'Authorization': jwt,
        },
        contentType: 'multipart/form-data'
      ),
    );

    print(response);
    // 여기에서 응답을 처리할 수 있습니다.
  } catch (e) {
    // 오류 처리
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


