import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RecipeDataInput{
  int heartCount;
  int reviewCount;
  RecipeData data;

  RecipeDataInput(this.heartCount,this.reviewCount,this.data);

  factory RecipeDataInput.fromJson(Map<String, dynamic> mainContent) {
    return RecipeDataInput(
      mainContent['heartCount'],
      mainContent['reviewCount'],
      RecipeData.fromJson(mainContent['data'],),
    );
  }
}
class RecipeData{
  int recipeId;
  String foodName;
  List<String> ingredient;
  String category;
  String thumbnailImage;
  List<String> context;
  List<String> image;
  int likeCount;
  int viewCount;
  double ratingScore;
  int ratingPeople;
  List<ReviewResponseDtos> reviewResponseDtos;
  List<HeartDtos> heartDtos;

  RecipeData(
      this.recipeId, this.foodName,
      this.ingredient, this.category,
      this.thumbnailImage,this.context,
      this.image,this.likeCount, this.viewCount,
      this.ratingScore,this.ratingPeople,this.reviewResponseDtos,this.heartDtos
      );

  factory RecipeData.fromJson(Map<String, dynamic> mainContent) {
    List<String> imageList = mainContent['image'].split(', ');
    List<String> ingredientList = mainContent['ingredient'].split(',');
    List<String> contextList = mainContent['context'].split(new RegExp(r'\d+\.'));
    contextList.removeAt(0);
    List<ReviewResponseDtos> reviewList = (mainContent['reviewResponseDtos'] as List?)?.map((item) => ReviewResponseDtos.fromJson(item)).toList() ?? [];
    List<HeartDtos> heartList = (mainContent['heartDtos'] as List?)?.map((item) => HeartDtos.fromJson(item)).toList() ?? [];

    return RecipeData(
      mainContent['recipeId'] ?? 0,
      mainContent['foodName'] ?? '',
      ingredientList,
      mainContent['category'] ?? '',
      mainContent['thumbnailImage'] ?? 'https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',
      contextList,
      imageList,
      mainContent['likeCount'] ?? 0,
      mainContent['viewCount'] ?? 0,
      (mainContent['ratingScore'] ?? 0).toDouble(),
      mainContent['ratingPeople'] ?? 0,
      reviewList,
      heartList,
    );
  }

}

Future<RecipeDataInput> fetchRecipe(id) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.get('$baseUrl/api/db/$id');

  return makeRecipePage(response.data);
}

RecipeDataInput makeRecipePage(Map<String, dynamic> data) {
  return RecipeDataInput.fromJson(data);
}

class ReviewResponseDtos{
  int reviewId;
  String username;
  String comment;
  int likeCount;
  double ratingScore;
  String recipeThumbnailImage;

  ReviewResponseDtos(this.reviewId,this.username,this.comment,this.likeCount,this.ratingScore,this.recipeThumbnailImage);

  factory ReviewResponseDtos.fromJson(Map<String, dynamic> json) {
    return ReviewResponseDtos(
      json['reviewId'],
      json['username'],
      json['comment'],
      json['likeCount'],
      json['ratingScore'],
      json['recipeThumbnailImage'],
    );
  }
}

class HeartDtos{
  int userId;
  int recipeId;
  String foodName;
  String category;
  String ingredient;

  HeartDtos(this.userId,this.recipeId,this.foodName,this.category,this.ingredient);

  factory HeartDtos.fromJson(Map<String, dynamic> json) {
    return HeartDtos(
      json['userId'],
      json['recipeId'],
      json['foodName'],
      json['category'],
      json['ingredient'],
    );
  }
}