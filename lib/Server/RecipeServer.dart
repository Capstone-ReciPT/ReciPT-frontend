import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:recipt/main.dart';

class RecipeDataInputFlag{
  RecipeDataInput recipeDataInput;
  bool registerFlag;

  RecipeDataInputFlag( this.recipeDataInput, this.registerFlag);

  factory RecipeDataInputFlag.fromJson(data, bool registerFlag) {
    return RecipeDataInputFlag(
        RecipeDataInput.fromJson(data,registerFlag),
        registerFlag
    );
  }
}
class RecipeDataInput{
  bool heartCheck;
  int heartCount;
  int reviewCount;
  var data;

  RecipeDataInput(this.heartCheck,this.heartCount,this.reviewCount,this.data);

  factory RecipeDataInput.fromJson(Map<String, dynamic> mainContent,registerFlag) {
    if(registerFlag){
      return RecipeDataInput(
        mainContent['heartCheck'],
        mainContent['heartCount'],
        mainContent['reviewCount'],
        RegisterRecipe.fromJson(mainContent['data'])
      );
    } else {
      return RecipeDataInput(
        mainContent['heartCheck'],
        mainContent['heartCount'],
        mainContent['reviewCount'],
        RecipeData.fromJson(mainContent['data'],),
      );
    }
  }
}

class RegisterRecipe {
  final String foodName;
  final String comment;
  final String category;
  final List<String> ingredient;
  final List<String> context;
  final Uint8List thumbnailByte;
  final List<Uint8List> imageByte;
  final String lastModifiedDate;

  RegisterRecipe({
    required this.foodName,
    required this.comment,
    required this.category,
    required this.ingredient,
    required this.context,
    required this.thumbnailByte,
    required this.imageByte,
    required this.lastModifiedDate,
  });

  factory RegisterRecipe.fromJson(Map<String, dynamic> json) {
    List<String> ingredientList = json['ingredient'].split(',');
    List<String> contextList = json['context'].split(RegExp(r'\d+\.'));
    contextList.removeAt(0);
    return RegisterRecipe(
      foodName: json['foodName'],
      comment: json['comment'],
      category: json['category'],
      ingredient: ingredientList,
      context: contextList,
      thumbnailByte : base64Decode(json['thumbnailByte'] ?? ''),
      imageByte: (json['imageByte'] as List).map((image) => base64Decode(image ?? '') as Uint8List).toList(),
      lastModifiedDate: json['lastModifiedDate'],
    );
  }
}
class RecipeData{
  var recipeId;
  String foodName;
  List<String> ingredient;
  String category;
  String thumbnailImage;
  List<String> context;
  List<String>? image;
  int likeCount;
  int viewCount;
  double ratingScore;
  int ratingPeople;
  List<ReviewResponseDto> reviewResponseDtos;
  List<HeartDtos> heartDtos;

  RecipeData(
      this.recipeId, this.foodName,
      this.ingredient, this.category,
      this.thumbnailImage,this.context,
      this.image,this.likeCount, this.viewCount,
      this.ratingScore,this.ratingPeople,this.reviewResponseDtos,this.heartDtos
      );

  factory RecipeData.fromJson(Map<String, dynamic> mainContent) {

    List<String>? imageList;
    if (mainContent['image'][0].startsWith('s_')) {
      imageList = null;
    } else {
      imageList = mainContent['image'].split(', ');
    }
    List<String> ingredientList = mainContent['ingredient'].split(',');
    List<String> contextList = mainContent['context'].split(RegExp(r'\d+\.'));
    contextList.removeAt(0);
    List<ReviewResponseDto> reviewList = (mainContent['reviewResponseDtos'] as List?)?.map((item) => ReviewResponseDto.fromJson(item)).toList() ?? [];
    List<HeartDtos> heartList = (mainContent['heartDtos'] as List?)?.map((item) => HeartDtos.fromJson(item)).toList() ?? [];
    return RecipeData(
      mainContent['recipeId'] ?? 0,
      mainContent['foodName'] ?? '',
      ingredientList,
      mainContent['category'] ?? '',
      mainContent['thumbnailImage'] ?? 'https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',
      contextList,
      imageList,
      mainContent['likeCount'] ?? 0,
      mainContent['viewCount'] ?? 0,
      (mainContent['ratingScore'] ?? 0).toDouble(),
      mainContent['ratingPeople'] ?? 0,
      reviewList,
      heartList,
    );
  }

}

Future<RecipeDataInputFlag> fetchRecipe(id) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  print(id);
  final response = await dio.get(
      '$baseUrl/api/db/$id',
    options: Options(
      headers: {
        'accessToken': jwt,  // jwt 토큰 추가
        'Authorization': 'Bearer $jwt',
      },
    ),
  );
  if(response.data['code'] == 500){
    final response = await dio.get(
      '$baseUrl/api/register/$id',
      options: Options(
        headers: {
          'accessToken': jwt,  // jwt 토큰 추가
          'Authorization': 'Bearer $jwt',
        },
      ),
    );
    return makeRecipePage(response.data,true);
  }
  return makeRecipePage(response.data,false);
}

RecipeDataInputFlag makeRecipePage(data,bool flag) {
  return RecipeDataInputFlag.fromJson(data, flag);
}

class ReviewResponseDto {
  final String foodName;
  final String username;
  final String comment;
  final int likeCount;
  final double ratingScore;
  final String recipeThumbnailImage;

  ReviewResponseDto({
    required this.foodName,
    required this.username,
    required this.comment,
    required this.likeCount,
    required this.ratingScore,
    required this.recipeThumbnailImage,
  });

  factory ReviewResponseDto.fromJson(Map<String, dynamic> json) {
    return ReviewResponseDto(
      foodName: json['foodName'],
      username: json['username'],
      comment: json['comment'],
      likeCount: json['likeCount'],
      ratingScore: json['ratingScore'].toDouble(),
      recipeThumbnailImage: json['recipeThumbnailImage'],
    );
  }
}


class HeartDtos{
  int userId;
  int recipeId;
  String foodName;
  String category;
  String ingredient;

  HeartDtos(this.userId,this.recipeId,this.foodName,this.category,this.ingredient);

  factory HeartDtos.fromJson(Map<String, dynamic> json) {
    return HeartDtos(
      json['userId'],
      json['recipeId'],
      json['foodName'],
      json['category'],
      json['ingredient'],
    );
  }
}