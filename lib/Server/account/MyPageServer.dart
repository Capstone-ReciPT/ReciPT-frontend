import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/category/CategoryServer.dart';
import 'dart:convert';

import 'package:recipt/Server/JWT/jwt.dart';

import 'dart:convert';
import 'dart:typed_data';

class UserProfile {
  int heartCount;
  int reviewCount;
  int registerRecipeSize;
  UserData data;
  Uint8List profile;

  UserProfile({
    required this.heartCount,
    required this.reviewCount,
    required this.registerRecipeSize,
    required this.data,
    required this.profile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      heartCount: json['heartCount'],
      reviewCount: json['reviewCount'],
      registerRecipeSize: json['registerRecipeSize'],
      data: UserData.fromJson(json['data']),
      profile: base64Decode(json['profile']),
    );
  }
}

class UserData {
  int userId;
  String username;
  String loginId;
  String password;
  int age;
  List<RecipeHeartDto> recipeHeartDtos;
  List<RegisterHeartDto> registerHeartDtos;
  List<dynamic> recipeReviewResponseDtos; // Assuming no structure provided
  List<dynamic> registerRecipeReviewResponseDtos; // Assuming no structure provided
  List<UserRegisterDto> userRegisterDtos;

  UserData({
    required this.userId,
    required this.username,
    required this.loginId,
    required this.password,
    required this.age,
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
      recipeHeartDtos: (json['recipeHeartDtos'] as List)
          .map((i) => RecipeHeartDto.fromJson(i))
          .toList(),
      registerHeartDtos: (json['registerHeartDtos'] as List)
          .map((i) => RegisterHeartDto.fromJson(i))
          .toList(),
      recipeReviewResponseDtos: json['recipeReviewResponseDtos'], // Assuming list of dynamic objects
      registerRecipeReviewResponseDtos: json['registerRecipeReviewResponseDtos'], // Assuming list of dynamic objects
      userRegisterDtos: (json['userRegisterDtos'] as List)
          .map((i) => UserRegisterDto.fromJson(i))
          .toList(),
    );
  }
}

class RecipeHeartDto {
  int userId;
  int recipeId;
  String foodName;
  String category;
  String ingredient;
  String thumbnailImage;

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
}

class RegisterHeartDto {
  int userId;
  int registerId;
  String foodName;
  String category;
  String ingredient;
  Uint8List thumbnailImageByte;

  RegisterHeartDto({
    required this.userId,
    required this.registerId,
    required this.foodName,
    required this.category,
    required this.ingredient,
    required this.thumbnailImageByte,
  });

  factory RegisterHeartDto.fromJson(Map<String, dynamic> json) {
    return RegisterHeartDto(
      userId: json['userId'],
      registerId: json['registerId'],
      foodName: json['foodName'],
      category: json['category'],
      ingredient: json['ingredient'],
      thumbnailImageByte: base64Decode(json['thumbnailImageByte']),
    );
  }
}

class UserRegisterDto {
  int? registerId;
  String foodName;
  String comment;
  String category;
  String ingredient;
  String context;
  int likeCount;
  double ratingResult;
  int ratingPeople;
  Uint8List thumbnailImageByte;
  DateTime lastModifiedDate;

  UserRegisterDto({
    this.registerId,
    required this.foodName,
    required this.comment,
    required this.category,
    required this.ingredient,
    required this.context,
    required this.likeCount,
    required this.ratingResult,
    required this.ratingPeople,
    required this.thumbnailImageByte,
    required this.lastModifiedDate,
  });

  factory UserRegisterDto.fromJson(Map<String, dynamic> json) {
    return UserRegisterDto(
      registerId : json['registerId'],
      foodName: json['foodName'],
      comment: json['comment'],
      category: json['category'],
      ingredient: json['ingredient'],
      context: json['context'],
      likeCount: json['likeCount'],
      ratingResult: json['ratingResult'].toDouble(),
      ratingPeople: json['ratingPeople'],
      thumbnailImageByte: base64Decode(json['thumbnailImageByte']),
      lastModifiedDate: DateTime.parse(json['lastModifiedDate']),
    );
  }
}

Future<UserProfile> fetchUser() async{
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
  var result = UserProfile.fromJson(response.data);
  return result;
}
