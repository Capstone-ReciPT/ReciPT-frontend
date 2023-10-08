import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/CategoryServer.dart';

import 'JWT/jwt.dart';

class GPTSuggest{
  final int code;
  final String message;
  final String data;

  GPTSuggest(this.code, this.message, this.data);

  factory GPTSuggest.fromJson(Map<String, dynamic> mainContent) {
    return GPTSuggest(
      mainContent['code'] ?? 0,
      mainContent['message'] ?? '',
      mainContent['data'] ?? ''
    );
  }
}

Future<List<List<String>>> fetchGPTsuggest(String ingre) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();
  final response = await dio.post('$baseUrl/api/chat/send',
      data: {ingre},
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
      }, // Content-Type 헤더 설정
    ),
  );
  return parseStringToList(response.data);
}


Future<List<List<String>>> parseStringToList(Map<String, dynamic> jsonData) {
  final String innerData = jsonData['data'];
  final Map<String, dynamic> parsedInnerData = jsonDecode(innerData);
  final List<dynamic> responseList = parsedInnerData['response'];

  print(responseList);
  List<List<String>> result = [];
  for (var item in responseList) {
    String ingredients = item['requiredIngredient'].toString();
    List<String> foodInfo = [
      item['recommendedFood'].toString(),
      ingredients, // 재료들은 한 문자열로 합쳐져 있습니다.
    ];
    result.add(foodInfo);
  }

  print(result);
  return Future.value(result);
}


