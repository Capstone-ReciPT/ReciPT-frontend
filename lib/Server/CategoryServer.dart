import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class CategoryRecipe {
  final int recipeId;
  final String foodName;
  final String thumbnailImage;
  final int likeCount;
  final String category;

  CategoryRecipe(this.recipeId, this.foodName, this.thumbnailImage, this.likeCount,this.category);

  factory CategoryRecipe.fromJson(Map<String, dynamic> mainContent) {
    return CategoryRecipe(
      mainContent['recipeId'],
      mainContent['foodName'],
      mainContent['thumbnailImage'] ?? 'https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',
      mainContent['likeCount'],
      mainContent['category'],
    );
  }
}

Future<List<CategoryRecipe>> fetchCategory(String selectedCategory) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.get('$baseUrl/api/category/recipes?category=$selectedCategory');
  return makeCategoryList(response.data);
}

List<CategoryRecipe> makeCategoryList(Map<String, dynamic> data) {
  List<CategoryRecipe> res  = [];

  for(int i = 0; i < data['recipeCount']; i++) {
    res.add(CategoryRecipe.fromJson(data['recipeList'][i]));
  }
  for(int i = 0; i < data['registerRecipeCount']; i++) {
    res.add(CategoryRecipe.fromJson(data['registerRecipeList'][i]));
  }
  return res;
}



