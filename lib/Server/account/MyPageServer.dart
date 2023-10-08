import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/category/CategoryServer.dart';
import 'dart:convert';

import 'package:recipt/Server/JWT/jwt.dart';

class MypageUser {
  final int userId;
  final String username;
  final Uint8List profileData;

  MypageUser(this.userId, this.username, this.profileData,);

  factory MypageUser.fromJson(Map<String, dynamic> mainContent, String profile) {
    return MypageUser(
      mainContent['userId'],
      mainContent['username'],
      base64Decode(profile ?? ''),
    );
  }
}
Future<MypageUser> fetchUser() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  final response = await dio.get(
      '$baseUrl/api/user',
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  return MypageUser.fromJson(response.data['data'],response.data['profile']);
}
//
// class RegisterRecipe{
//   final String comment;
//   final String category;
//   final String
// }
