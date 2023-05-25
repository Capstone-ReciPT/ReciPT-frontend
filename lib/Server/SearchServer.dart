import 'package:dio/dio.dart';
import 'package:recipt/Server/CategoryServer.dart';

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
      mainContent['thumbnailImage'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      mainContent['likeCount'] ?? 0,
      mainContent['category'] ?? '',
    );
  }
}



Future<List<CategoryRecipe>> fetchSearch(String userInput) async{
  final dio = Dio();
  final response = await dio.get('http://10.0.2.2:8080/api/search/recipes?foodName=$userInput');
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
