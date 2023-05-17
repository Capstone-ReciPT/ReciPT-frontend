import 'package:dio/dio.dart';

final dio = Dio();

class SuggestFood{
  final int count;
  final List<String> foodName;

  SuggestFood(this.count, this.foodName);

}
Future<List<String>> fetchSuggest() async{
  final response = await dio.get('http://10.0.2.2:8080/api/search');
  print(response);
  return response.data['foodName'];
}
