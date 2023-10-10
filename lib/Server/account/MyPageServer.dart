import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/category/CategoryServer.dart';
import 'dart:convert';

import 'package:recipt/Server/JWT/jwt.dart';

import 'dart:convert';
import 'dart:typed_data';

class MypageUser {
  int heartCount;
  int reviewCount;
  int registerRecipeSize;
  UserData data;
  Uint8List profile; // 바이트 코드의 경우 String으로 처리했으나 실제 데이터 타입에 따라 변경이 필요합니다.

  MypageUser({
    required this.heartCount,
    required this.reviewCount,
    required this.registerRecipeSize,
    required this.data,
    required this.profile,
  });

  factory MypageUser.fromJson(Map<String, dynamic> json) {
    return MypageUser(
      heartCount: json['heartCount'],
      reviewCount: json['reviewCount'],
      registerRecipeSize: json['registerRecipeSize'],
      data: UserData.fromJson(json['data']),
      profile: base64Decode(json['profile'] ?? ''),
    );
  }
}

class UserData {
  int userId;
  String username;
  String loginId;
  String password;
  int age;
  String profile;
  List<dynamic> recipeHeartDtos; // 리스트의 정확한 타입이 제공되지 않았기 때문에 일단 dynamic으로 설정했습니다.
  List<dynamic> registerHeartDtos;
  List<dynamic> recipeReviewResponseDtos;
  List<dynamic> registerRecipeReviewResponseDtos;
  List<UserRegisterDto> userRegisterDtos;

  UserData({
    required this.userId,
    required this.username,
    required this.loginId,
    required this.password,
    required this.age,
    required this.profile,
    required this.recipeHeartDtos,
    required this.registerHeartDtos,
    required this.recipeReviewResponseDtos,
    required this.registerRecipeReviewResponseDtos,
    required this.userRegisterDtos,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'],
      username: json['username'],
      loginId: json['loginId'],
      password: json['password'],
      age: json['age'],
      profile: json['profile'],
      recipeHeartDtos: (json['recipeHeartDtos'] as List)
          .map((e) => RecipeHeartDto.fromJson(e))
          .toList(),
      registerHeartDtos: json['registerHeartDtos'],
      recipeReviewResponseDtos: json['recipeReviewResponseDtos'],
      registerRecipeReviewResponseDtos: json['registerRecipeReviewResponseDtos'],
      userRegisterDtos: (json['userRegisterDtos'] as List)
          .map((e) => UserRegisterDto.fromJson(e))
          .toList(),
    );
  }
}

class UserRegisterDto {
  String foodName;
  String comment;
  String category;
  String ingredient;
  String context;
  int likeCount;
  double ratingResult;
  int ratingPeople;
  String thumbnailImage;
  Uint8List thumbnailImageByte;
  String lastModifiedDate;

  UserRegisterDto({
    required this.foodName,
    required this.comment,
    required this.category,
    required this.ingredient,
    required this.context,
    required this.likeCount,
    required this.ratingResult,
    required this.ratingPeople,
    required this.thumbnailImage,
    required this.thumbnailImageByte,
    required this.lastModifiedDate,
  });

  factory UserRegisterDto.fromJson(Map<String, dynamic> json) {
    return UserRegisterDto(
      foodName: json['foodName'],
      comment: json['comment'],
      category: json['category'],
      ingredient: json['ingredient'],
      context: json['context'],
      likeCount: json['likeCount'],
      ratingResult: json['ratingResult'].toDouble(),
      ratingPeople: json['ratingPeople'],
      thumbnailImage: json['thumbnailImage'],
      thumbnailImageByte: base64Decode(json['thumbnailImageByte'] ?? ''),
      lastModifiedDate: json['lastModifiedDate'],
    );
  }
}

class RecipeHeartDto{
  final int userId;
  final int recipeId;
  final String foodName;
  final String category;
  final String ingredient;
  final String thumbnailImage;

  RecipeHeartDto({
    required this.userId,
    required this.recipeId,
    required this.foodName,
    required this.category,
    required this.ingredient,
    required this.thumbnailImage,
  });

  factory RecipeHeartDto.fromJson(Map<String, dynamic> json) {
    return RecipeHeartDto(
      userId: json['userId'],
      recipeId: json['recipeId'],
      foodName: json['foodName'],
      category: json['category'],
      ingredient: json['ingredient'],
      thumbnailImage: json['thumbnailImage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'recipeId': recipeId,
      'foodName': foodName,
      'category': category,
      'ingredient': ingredient,
      'thumbnailImage': thumbnailImage,
    };
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
  var result = MypageUser.fromJson(response.data);
  return result;
}
//
// class RegisterRecipe{
//   final String comment;
//   final String category;
//   final String
// }
