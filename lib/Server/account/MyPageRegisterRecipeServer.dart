import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class UserData {
  int userId;
  String username;
  String loginId;
  String password;
  int age;
  String profile;
  List<dynamic> recipeHeartDtos;
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

  factory UserData.fromJson(Map<String, dynamic> json,data) {
    return UserData(
      userId: json['userId'],
      username: json['username'],
      loginId: json['loginId'],
      password: json['password'],
      age: json['age'],
      profile: json['profile'],
      recipeHeartDtos: json['recipeHeartDtos'],
      registerHeartDtos: json['registerHeartDtos'],
      recipeReviewResponseDtos: json['recipeReviewResponseDtos'],
      registerRecipeReviewResponseDtos: json['registerRecipeReviewResponseDtos'],
      userRegisterDtos: (json['userRegisterDtos'] as List)
          .map((i) => UserRegisterDto.fromJson(i,data))
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
  Uint8List thumbnailImage;
  List<String> images;
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
    required this.images,
    required this.lastModifiedDate,
  });

  factory UserRegisterDto.fromJson(Map<String, dynamic> json,data) {
    return UserRegisterDto(
      foodName: json['foodName'],
      comment: json['comment'],
      category: json['category'],
      ingredient: json['ingredient'],
      context: json['context'],
      likeCount: json['likeCount'],
      ratingResult: json['ratingResult'].toDouble(),
      ratingPeople: json['ratingPeople'],
      thumbnailImage: base64Decode(data['registerProfile'] ?? ''),
      images: List<String>.from(json['images']),
      lastModifiedDate: json['lastModifiedDate'],
    );
  }
}

Future<UserData> fetchUserRegisterRecipe() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  final response = await dio.get(
    '$baseUrl/api/user/register',
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  var result = UserData.fromJson(response.data['data'],response.data);
  return result;
}