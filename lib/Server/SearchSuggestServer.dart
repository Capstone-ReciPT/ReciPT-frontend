import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/CategoryServer.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class SuggestFood{
  final String foodName;

  SuggestFood(this.foodName);

  factory SuggestFood.fromJson(String foodName) {
    return SuggestFood(foodName);

  }
}

Future<List<SuggestFood>> fetchSuggest() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  final response = await dio.get(
      '$baseUrl/api/search',
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  return makeSuggestList(response.data);
}

List<SuggestFood> makeSuggestList(Map<String, dynamic> data) {
  List<SuggestFood> res  = [];
  List<String> foodNames = List<String>.from(data['foodName']);

  for(int i = 0; i < foodNames.length; i++) {
    res.add(SuggestFood.fromJson(foodNames[i]));
  }
  return res;
}





