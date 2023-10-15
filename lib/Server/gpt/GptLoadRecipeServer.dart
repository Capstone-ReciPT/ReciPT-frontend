import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class ShowGptRecipe {
  int count;
  List<SomeRecipeData> data;

  ShowGptRecipe({required this.count, required this.data});

  factory ShowGptRecipe.fromJson(Map<String, dynamic> json) {
    return ShowGptRecipe(
      count: json['count'],
      data: (json['data'] as List).map((i) => SomeRecipeData.fromJson(i)).toList(),
    );
  }
}

class SomeRecipeData {
  int gptId;
  String foodName;
  String createdDate;

  SomeRecipeData({required this.gptId, required this.foodName, required this.createdDate});

  factory SomeRecipeData.fromJson(Map<String, dynamic> json) {
    return SomeRecipeData(
      gptId: json['gptId'],
      foodName: json['foodName'],
      createdDate: json['createdDate'],
    );
  }
}

Future<ShowGptRecipe?> fetchLoadGptRecipeCover() async {
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();

  final response = await dio.get('$baseUrl/api/register/show/recipes',
    options: Options(
      headers: {
        'Content-Type': 'text/plain',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );

  if(response.data['code'] != 500){
    return ShowGptRecipe.fromJson(response.data);
  } else{
    return null;
  }
}
