import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:recipt/Server/CategoryServer.dart';

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

Future<List<String>> fetchGPTsuggest(String ingre) async{

  final dio = Dio();
  final response = await dio.post('http://10.0.2.2:8080/api/chat/send',
      data: {ingre},
    options: Options(
      headers: {'Content-Type': 'text/plain'}, // Content-Type 헤더 설정
    ),
  );
  print(response.data);
  return parseStringToList(response.data['data']);
}


List<String> parseStringToList(String jsonString) {
  List<String> resultList = [];

  // JSON 문자열을 파싱하여 Map 형태로 변환
  Map<String, dynamic> parsedJson = jsonDecode(jsonString);

  // "recommendFood" 키의 값을 가져옴
  String recommendFood = parsedJson['recommendFood'];

  // 쉼표를 기준으로 문자열을 분리하여 리스트에 추가
  resultList = recommendFood.split(',').map((e) => e.trim()).toList();

  return resultList;
}


