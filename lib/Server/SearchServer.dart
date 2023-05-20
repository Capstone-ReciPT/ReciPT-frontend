import 'package:dio/dio.dart';
import 'package:recipt/Server/CategoryServer.dart';



Future<List<CategoryRecipe>> fetchSearch(userInput) async{
  final dio = Dio();
  final response = await dio.get('http://192.168.0.15:8080/api/search/recipes?foodName=$userInput');
  print(response);
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
  print(res);
  return res;
}
