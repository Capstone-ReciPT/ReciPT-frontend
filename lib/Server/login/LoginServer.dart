import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<int> loginFunc(id, pw) async {
  final dio = Dio();
  print('id = $id, pw = $pw');

  String? baseUrl = dotenv.env['BASE_URL'];
  final response = await dio.post(
      '$baseUrl/api/login',
    data: {
      'loginId': id,
      'password': pw,
    },
  );
  print(response.data);
  if (response.data['state'] == 200){
    var data = response.data;
    print(data);
    storeJwt(data['data']['accessToken'],data['data']['refreshToken']);
    return 200;
  }
  else if (response.data['state'] == 400){
    print(response.statusCode);
    return 400;
  } else{
    return 500;
  }
}

Future<bool> logout() async {
  final dio = Dio();
  String jwt = await getJwt();
  String refresh = await getRefresh();
  String? baseUrl = dotenv.env['BASE_URL'];

  final response = await dio.post(
    '$baseUrl/api/logout',
    options: Options(
      headers: {
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt.toString(),
        'refreshToken':refresh.toString()
      }, // Content-Type 헤더 설정
    ),
  );
  print(response);

  // if(response.data['state'] == 200){
  //   return true;
  // }
  // else{
  //   return false;
  // }

  return true;
}

