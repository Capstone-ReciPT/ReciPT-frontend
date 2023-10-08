import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/category/CategoryServer.dart';
import 'dart:convert';

import 'package:recipt/Server/JWT/jwt.dart';

import 'dart:convert';
import 'dart:typed_data';

class MypageUser {
  final int userId;
  final String username;
  final String loginId;
  final String password;
  final int age;
  final Uint8List profileData;

  final List<RegisterRecipe> registerRecipe;


  MypageUser({
    required this.userId,
    required this.username,
    required this.loginId,
    required this.password,
    required this.age,
    required this.profileData,
    required this.registerRecipe,
  });

  factory MypageUser.fromJson(Map<String, dynamic> jsonData, String profile) {
    List<dynamic>? rawList = jsonData['registerResponseDtos'];
    List<RegisterRecipe> toClass = (rawList ?? [])
        .map((item) => RegisterRecipe.fromJson(item))
        .toList();

    return MypageUser(
      userId: jsonData['userId'],
      username: jsonData['username'],
      loginId: jsonData['loginId'],
      password: jsonData['password'],
      age: jsonData['age'],
      profileData: base64Decode(profile ?? ''),
      registerRecipe: toClass
    );
  }
}

class RecipeHeart {
  final int userId;
  final int recipeId;
  final String foodName;
  final String category;
  final String ingredient;

  RecipeHeart({
    required this.userId,
    required this.recipeId,
    required this.foodName,
    required this.category,
    required this.ingredient,
  });

  factory RecipeHeart.fromJson(Map<String, dynamic> jsonData) {
    return RecipeHeart(
      userId: jsonData['userId'],
      recipeId: jsonData['recipeId'],
      foodName: jsonData['foodName'],
      category: jsonData['category'],
      ingredient: jsonData['ingredient'],
    );
  }
}

class RegisterRecipe {
  final String foodName;
  final String comment;
  final String category;
  final String ingredient;
  final String context;
  final String thumbnailImage;
  final List<String> images;
  final DateTime lastModifiedDate;

  RegisterRecipe({
    required this.foodName,
    required this.comment,
    required this.category,
    required this.ingredient,
    required this.context,
    required this.thumbnailImage,
    required this.images,
    required this.lastModifiedDate,
  });

  factory RegisterRecipe.fromJson(Map<String, dynamic> json) {
    return RegisterRecipe(
      foodName : json['foodName'],
      comment: json['comment'],
      category: json['category'],
      ingredient: json['ingredient'],
      context: json['context'],
      thumbnailImage: json['thumbnailImage'],
      images: List<String>.from(json['images']),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate']),
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
  var result = MypageUser.fromJson(response.data['data'],response.data['profile']);
  return result;
}
//
// class RegisterRecipe{
//   final String comment;
//   final String category;
//   final String
// }
