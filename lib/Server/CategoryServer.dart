import 'package:dio/dio.dart';

final dio = Dio();

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
      mainContent['thumbnailImage'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      mainContent['likeCount'],
      mainContent['category'],
    );
  }
}

Future<List<CategoryRecipe>> fetchCategory(String selectedCategory) async{
  final response = await dio.get('http://192.168.0.9:8080/api/category/recipes?category=$selectedCategory');
  print(makeCategoryList(response.data));
  return makeCategoryList(response.data);
}


List<CategoryRecipe> makeCategoryList(Map<String, dynamic> data) {
  List<CategoryRecipe> res  = [];

  for(int i = 0; i < data['dbRecipeCount']; i++) {
    res.add(CategoryRecipe.fromJson(data['recipeList'][i]));
  }
  for(int i = 0; i < data['registerRecipeCount']; i++) {
    res.add(CategoryRecipe.fromJson(data['registerRecipeList'][i]));
  }
  return res;
}

