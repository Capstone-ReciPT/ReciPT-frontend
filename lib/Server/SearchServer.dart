import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/CategoryServer.dart';
import 'package:recipt/Server/JWT/jwt.dart';

class SearchJson{
  int recipeCount;
  int registerRecipeCount;
  RecipeList recipeList;
  final registerRecipeList;

  SearchJson(this.recipeCount,this.registerRecipeCount,this.recipeList,this.registerRecipeList);
  factory SearchJson.fromJson(Map<String, dynamic> mainContent) {
    return SearchJson(
      mainContent['heartCount'],
      mainContent['reviewCount'],
      RecipeList.fromJson(mainContent['data'],),
      mainContent['registerRecipeList']
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
      mainContent['thumbnailImage'] ?? 'https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',
      mainContent['likeCount'] ?? 0,
      mainContent['category'] ?? '',
    );
  }
}



Future<List<CategoryRecipe>> fetchSearch(String userInput) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();
  final response = await dio.post(
      '$baseUrl/api/search/recipes?foodName=$userInput&like=&view=',
    options: Options(
      headers: {
        'accessToken': jwt,  // jwt 토큰 추가
      },
    ),
  );
  return makeSearchedList(response.data);
}

List<CategoryRecipe> makeSearchedList(Map<String, dynamic> data) {
  List<CategoryRecipe> res  = [];

  for(int i = 0; i < data['recipeCount']; i++) {
    res.add(CategoryRecipe.fromJson(data['recipeList'][i]));
  }
  for(int i = 0; i < data['registerRecipeCount']; i++) {
    res.add(CategoryRecipe.fromJson(data['registerRecipeList'][i]));
  }
  return res;
}
