import 'package:dio/dio.dart';

final dio = Dio();

class SuggestFood{
  final String foodName;

  SuggestFood(this.foodName);

  factory SuggestFood.fromJson(String foodName) {
    return SuggestFood(foodName);

  }
}

Future<List<SuggestFood>> fetchSuggest() async{
  final response = await dio.get('http://10.0.2.2:8080/api/search');
  print(response.data);
  return makeCategoryList(response.data);
}

List<SuggestFood> makeCategoryList(Map<String, dynamic> data) {
  List<SuggestFood> res  = [];
  List<String> foodNames = List<String>.from(data['foodName']);

  for(int i = 0; i < foodNames.length; i++) {
    res.add(SuggestFood.fromJson(foodNames[i]));
  }
  print(res);
  return res;
}

Future<List<String>> fetchSearch(_userInput) async{
  final response = await dio.post('http://10.0.2.2:8080/api/search',data: {'foodName':_userInput, 'like':'','view':''});
  print(response.data['foodName']);
  return response.data['foodName'];
}

