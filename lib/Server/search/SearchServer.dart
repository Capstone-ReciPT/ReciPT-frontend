import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/category/CategoryServer.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class SearchJson{
  int recipeCount;
  int registerRecipeCount;
  List<RecipeList> recipeList;
  List<RegisterRecipeList> registerRecipeList;

  SearchJson(this.recipeCount,this.registerRecipeCount,this.recipeList,this.registerRecipeList);
  factory SearchJson.fromJson(Map<String, dynamic> mainContent) {
    return SearchJson(
      mainContent['recipeCount'],
      mainContent['registerRecipeCount'],
        (mainContent['recipeList'] as List).map((item) => RecipeList.fromJson(item)).toList(),
        (mainContent['registerRecipeList'] as List).map((item) => RegisterRecipeList.fromJson(item)).toList()
    );
  }
}

class RecipeList{
  int recipeId;
  String foodName;
  String thumbnailImage;
  int likeCount;
  String category;

  RecipeList(this.recipeId,this.foodName,this.thumbnailImage,this.likeCount,this.category);

  factory RecipeList.fromJson(Map<String, dynamic> mainContent) {
    return RecipeList(
      mainContent['recipeId'] ?? 0,
      mainContent['foodName'] ?? '',
      mainContent['thumbnailImage'] ?? '',
      mainContent['likeCount'] ?? 0,
      mainContent['category'] ?? '',
    );
  }
}

class RegisterRecipeList{
  final int registerId;
  final String username;
  final String foodName;
  final int likeCount;
  final String category;
  final String thumbnailImage;
  final Uint8List thumbnailImageByte;

  RegisterRecipeList({
    required this.registerId,
    required this.username,
    required this.foodName,
    required this.likeCount,
    required this.category,
    required this.thumbnailImage,
    required this.thumbnailImageByte,
  });

  factory RegisterRecipeList.fromJson(Map<String, dynamic> json) {
    print(json);
    return RegisterRecipeList(
      registerId: json['registerId'],
      username: json['username'],
      foodName: json['foodName'],
      likeCount: json['likeCount'],
      category: json['category'],
      thumbnailImage: json['thumbnailImage'],
      thumbnailImageByte: base64Decode(json['thumbnailImageByte']),
    );
  }
}



Future<SearchJson> fetchSearch(String userInput) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();
  final response = await dio.post(
      '$baseUrl/api/search/recipes?foodName=$userInput&like=&view=',
    options: Options(
      headers: {
        'accessToken': jwt,  // jwt 토큰 추가
        'Authorization': 'Bearer $jwt',
      },
    ),
  );
  print(response.data);
  return makeSearchedList(response.data);
}

SearchJson makeSearchedList(Map<String, dynamic> data) {
  return SearchJson.fromJson(data);
}
