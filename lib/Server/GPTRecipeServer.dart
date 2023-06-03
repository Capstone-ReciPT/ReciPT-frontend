import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  final response = await dio.post('$baseUrl/api/chat/send',
    data: {food},
    options: Options(
      headers: {'Content-Type': 'text/plain'}, // Content-Type 헤더 설정
    ),
  );
  print(response.data);
  return parseStringToRecipe(response.data['data']);
}

GPTRecipe parseStringToRecipe(String jsonString) {
  Map<String, dynamic> parsedJson = jsonDecode(jsonString);

  print(parsedJson.toString());
  return GPTRecipe.fromJson(parsedJson);
}
void fetchGPTRefresh() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.post('$baseUrl/api/chat/refresh');
//10.0.2.2
}

// GPT 레시피 검색

Future<GPTRecipe> fetchGPTNoRecipe(String food) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.post('$baseUrl/api/chat/search',
    data: {food},
    options: Options(
      headers: {'Content-Type': 'text/plain'}, // Content-Type 헤더 설정
    ),
  );
  print(response.data);
  return parseStringToRecipe(response.data['data']);
}
