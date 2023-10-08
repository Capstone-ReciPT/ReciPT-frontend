import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:recipt/Server/gpt/GPTRecipeServer.dart';

Future<GPTRecipe> fetchGPTNoRecipe(String food) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();
  final response = await dio.post('$baseUrl/api/chat/search',
    data: {food},
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  return parseStringToRecipe(response.data['data']);
}