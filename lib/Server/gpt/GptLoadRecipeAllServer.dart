import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class AllGptRecipe {
  final String foodName;
  final List<String> ingredient;
  final List<String> context;

  AllGptRecipe({required this.foodName, required this.ingredient, required this.context});

  factory AllGptRecipe.fromJson(Map<String, dynamic> json) {
    String ingredient = json['ingredient'];
    if (ingredient.endsWith(',')) {
      ingredient = ingredient.substring(0, ingredient.length - 1);
    }
    List<String> ingredientList = ingredient.split(','); print(ingredientList);
    ingredientList.removeAt(0);
    List<String> contextList = json['context'].split(RegExp(r'\d+\.\s'))..removeAt(0);
    print(contextList);

    return AllGptRecipe(
        foodName: json['foodName'],
        ingredient: ingredientList,
        context: contextList
    );
  }
}

Future<AllGptRecipe> fetchLoadGptRecipeAll(gptId) async {
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  final response = await dio.get('$baseUrl/api/register/show/choice?gptId=$gptId',
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );
  print(response.data);
  return AllGptRecipe.fromJson(response.data['data']);
}



