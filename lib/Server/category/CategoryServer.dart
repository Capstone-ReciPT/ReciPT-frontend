import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class RecipeResponse {
  final String category;
  final int recipeCount;
  final int registerRecipeCount;
  final List<Recipe> recipeList;
  final List<RegisterRecipe> registerRecipeList;

  RecipeResponse({
    required this.category,
    required this.recipeCount,
    required this.registerRecipeCount,
    required this.recipeList,
    required this.registerRecipeList,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) {
    return RecipeResponse(
      category: json['category'],
      recipeCount: json['recipeCount'],
      registerRecipeCount: json['registerRecipeCount'],
      recipeList: (json['recipeList'] as List)
          .map((i) => Recipe.fromJson(i))
          .toList(),
      registerRecipeList: (json['registerRecipeList'] as List)
          .map((i) => RegisterRecipe.fromJson(i))
          .toList(),
    );
  }
}

class Recipe {
  final int recipeId;
  final String foodName;
  final String thumbnailImage;
  final int likeCount;
  final String category;

  Recipe({
    required this.recipeId,
    required this.foodName,
    required this.thumbnailImage,
    required this.likeCount,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      recipeId: json['recipeId'],
      foodName: json['foodName'],
      thumbnailImage: json['thumbnailImage'],
      likeCount: json['likeCount'],
      category: json['category'],
    );
  }
}

class RegisterRecipe {
  final int registerId;
  final String username;
  final String foodName;
  final int likeCount;
  final String category;
  final String thumbnailImage;
  final Uint8List thumbnailImageByte;

  RegisterRecipe({
    required this.registerId,
    required this.username,
    required this.foodName,
    required this.likeCount,
    required this.category,
    required this.thumbnailImage,
    required this.thumbnailImageByte,
  });

  factory RegisterRecipe.fromJson(Map<String, dynamic> json) {
    return RegisterRecipe(
      registerId: json['registerId'],
      username: json['username'],
      foodName: json['foodName'],
      likeCount: json['likeCount'],
      category: json['category'],
      thumbnailImage: json['thumbnailImage'],
      thumbnailImageByte: base64Decode(json['thumbnailImageByte'] ?? ''),
    );
  }
}

class Item {
  final int id;
  final String? thumbnailImage;
  final Uint8List? thumbnailImageByte;
  final String name;
  final String category;

  Item({
    required this.id,
    this.thumbnailImage,
    this.thumbnailImageByte,
    required this.name,
    required this.category,
  });
}

Future<RecipeResponse> fetchCategory(String selectedCategory) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.get('$baseUrl/api/category/recipes?category=$selectedCategory');
  return makeCategoryList(response.data);
}

RecipeResponse makeCategoryList(Map<String, dynamic> data) {
  return RecipeResponse.fromJson(data);
}



