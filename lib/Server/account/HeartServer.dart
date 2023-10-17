import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<int?> heartInsertFunc(id) async {
  final dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];
  String jwt = await getJwt();
  var response = await dio.post(
    '$baseUrl/api/register/insert/$id',
    options: Options(
      headers: {
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      },
    ),
  );
  print(response.data);
  if(response.data['code'] == 500){
    response = await dio.post(
        '$baseUrl/api/db/insert/$id',
        options: Options(
        headers: {
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
        },)
    );
  }
  return response.data['heartCount'];
}

Future<int?> heartCancelFunc(id) async {
  final dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];
  var jwt = await getJwt();
  var response = await dio.post(
    '$baseUrl/api/register/cancel/$id',
    options: Options(
      headers: {
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      },
    ),
  );
  print(response.data);
  if(response.data['code'] == 500){
    response = await dio.post(
        '$baseUrl/api/db/cancel/$id',
        options: Options(
        headers: {
          'Authorization': 'Bearer $jwt',
          'accessToken': jwt,
          },
    ));
  }

  return response.data['heartCount'];
}
