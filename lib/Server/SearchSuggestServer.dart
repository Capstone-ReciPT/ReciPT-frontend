import 'package:dio/dio.dart';
import 'package:recipt/Server/CategoryServer.dart';

class SuggestFood{
  final String foodName;

  SuggestFood(this.foodName);

  factory SuggestFood.fromJson(String foodName) {
    return SuggestFood(foodName);

  }
}

Future<List<SuggestFood>> fetchSuggest() async{
  final dio = Dio();
  final response = await dio.get('http://10.0.2.2:8080/api/search');
  return makeSuggestList(response.data);
}

List<SuggestFood> makeSuggestList(Map<String, dynamic> data) {
  List<SuggestFood> res  = [];
  List<String> foodNames = List<String>.from(data['foodName']);

  for(int i = 0; i < foodNames.length; i++) {
    res.add(SuggestFood.fromJson(foodNames[i]));
  }
  return res;
}





