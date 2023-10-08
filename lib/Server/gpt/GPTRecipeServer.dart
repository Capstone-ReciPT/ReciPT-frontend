import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class GPTRecipe{
  final String foodName;
  final List<String> ingredient;
  final List<String> context;

  GPTRecipe(this.foodName, this.ingredient, this.context);

  factory GPTRecipe.fromJson(Map<String, dynamic> mainContent) {
    List<String> ingredientList = mainContent['ingredient'].split(', ');
    List<String> contextList = mainContent['context'].split(new RegExp(r'\d+\.'));
    contextList.removeAt(0);
    return GPTRecipe(
      mainContent['foodName'],
      ingredientList,
      contextList,
    );
  }
}
Future<GPTRecipe> fetchGPTRecipe(String food) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
    String jwt = await getJwt();
  final response = await dio.post('$baseUrl/api/chat/send',
    data: {food},
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  print(response);
  return parseStringToRecipe(response.data['data']);
}

GPTRecipe parseStringToRecipe(String jsonString) {
  Map<String, dynamic> parsedJson = jsonDecode(jsonString);
  return GPTRecipe.fromJson(parsedJson);
}
void fetchGPTRefresh() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  final response = await dio.post(
      '$baseUrl/api/chat/refresh',
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  print('GPT 새로고침 완료');

//10.0.2.2
}

// GPT 레시피 검색


