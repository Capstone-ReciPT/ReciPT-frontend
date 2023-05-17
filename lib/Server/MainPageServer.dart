import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainRecipe {
  final int recipeId;
  final String foodName;
  final String thumbnailImage;
  final int likeCount;
  final int viewCount;
  final double ratingScore;

  MainRecipe(this.recipeId, this.foodName, this.thumbnailImage, this.likeCount, this.viewCount, this.ratingScore);

  factory MainRecipe.fromJson(Map<String, dynamic> mainContent) {
    return MainRecipe(
      mainContent['recipeId'],
      mainContent['foodName'],
      mainContent['thumbnailImage'],
      mainContent['likeCount'],
      mainContent['viewCount'],
      mainContent['ratingScore'],
    );
  }
}


Future<List<MainRecipe>> fetchUser(keyword) async {
  Uri uri = Uri.parse('http://10.0.2.2:8080/api/home');
  final response = await http.get(uri);

  // 웹 서버로부터 정상(200) 데이터 수신
  if (response.statusCode == 200) {
    // json 데이터를 수신해서 User 객체로 변환
    final mainContent = json.decode(utf8.decode(response.bodyBytes));
    return await makeHomeList(mainContent,keyword);
  }
  throw Exception('데이터 수신 실패!');
}

List<MainRecipe> makeHomeList(mainContent,keyword) {
  List<MainRecipe> res  = [];

  for(int i = 0; i < mainContent[keyword]['recipeCount']; i++) {
    res.add(MainRecipe.fromJson(mainContent[keyword]['data'][i.toString()]));
  }

  return res;

}