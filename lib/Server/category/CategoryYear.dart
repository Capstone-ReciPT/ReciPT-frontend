import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/category/CategoryServer.dart';

class CategoryYear{
  final int recipeId;
  final String foodName;
  final String thumbnailImage;
  final int likeCount;
  final int viewCount;
  final double ratingScore;

  CategoryYear(this.recipeId, this.foodName, this.thumbnailImage, this.likeCount, this.viewCount, this.ratingScore);

  factory CategoryYear.fromJson(Map<String, dynamic> mainContent) {
    return CategoryYear(
      mainContent['recipeId'],
      mainContent['foodName'],
      mainContent['thumbnailImage'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      mainContent['likeCount'],
      mainContent['viewCount'],
      mainContent['ratingScore'],
    );
  }

}
Future<List<CategoryYear>> fetchYear() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.get('$baseUrl/api/category');
  return makeYearList(response.data);
}

List<CategoryYear> makeYearList(Map<String, dynamic> data) {
  List<CategoryYear> res  = [];

  for(int i = 0; i < data['count']; i++) {
    res.add(CategoryYear.fromJson(data['data']['data'][i.toString()]));
  }

  return res;
}