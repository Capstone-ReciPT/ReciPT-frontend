import 'package:dio/dio.dart';

final dio = Dio();

void getHttp() async {
  final response = await dio.get('http://10.0.2.2:8080/api/home');
  print(response);
}