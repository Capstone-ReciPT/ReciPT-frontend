import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<bool> loginFunc(id, pw) async {
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
  if (response.statusCode == 200){
    var data = response.data;
    print(data);
    storeJwt(data['data']['accessToken'],data['data']['refreshToken']);
    return true;
  }
  else{
    print(response.statusCode);
    return false;
  }
}

// Future<bool> logout(id, pw) async {
//   final dio = Dio();
//
//   String? baseUrl = dotenv.env['BASE_URL'];
//   final response = await dio.post(
//     '$baseUrl/api/logout',
//     data: {
//       'loginId': id,
//       'password': pw,
//     },
//   );
//   print(response);
//   if (response.statusCode == 200){
//     final responseData = json.decode(response.body);
//     if (response.headers['Authorization'] != null) {
//       // Save the token
//       storeJwt(data);
//       return true;
//     }
//     return false;
//   }
//   else{
//     print(response.statusCode);
//     return false;
//   }
// }