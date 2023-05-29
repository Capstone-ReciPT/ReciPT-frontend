import 'dart:convert';

import 'package:dio/dio.dart';

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

  final dio = Dio();
  final response = await dio.post('http://192.168.0.15:8080/api/chat/send',
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
  final dio = Dio();
  final response = await dio.post('http://10.0.2.2:8080/api/chat/refresh');

}

// GPT 레시피 검색

Future<GPTRecipe> fetchGPTNoRecipe(String food) async{

  final dio = Dio();
  final response = await dio.post('http://192.168.0.15:8080/api/chat/search',
    data: {food},
    options: Options(
      headers: {'Content-Type': 'text/plain'}, // Content-Type 헤더 설정
    ),
  );
  print(response.data);
  return parseStringToRecipe(response.data['data']);
}
