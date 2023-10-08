import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<int> heartInsertFunc(id) async {
  final dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];
  String jwt = await getJwt();
  var response = await dio.post(
      '$baseUrl/api/db/insert/${id.toString()}',
      options: Options(
        headers: {
          'Authorization': 'Bearer $jwt',
          'accessToken': jwt,
        },
      ),
  );
  print(response);
  return response.data['heartCount'];

}

Future<int> heartCancelFunc(id) async {
  final dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];
  var jwt = await getJwt();
  try {
    var response = await dio.post(
      '$baseUrl/api/db/cancel/$id',
      options: Options(
        headers: {
          'Authorization': 'Bearer $jwt',  // jwt 토큰 추가
        },
      ),
    );
    if (response.statusCode == 200) {
      // 요청이 성공한 경우
      return response.data['heartCount'];
    } else {
      // 요청이 실패한 경우
      return 0;
    }
  } catch (e) {
    print('Error: $e');
    return 0;
  }
}
