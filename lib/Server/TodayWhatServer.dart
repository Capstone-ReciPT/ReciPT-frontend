import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GPTchat{
  final int code;
  final String message;
  final String data;

  GPTchat(this.code, this.message, this.data);

  factory GPTchat.fromJson(Map<String, dynamic> mainContent) {
    return GPTchat(
        mainContent['code'] ?? 0,
        mainContent['message'] ?? '',
        mainContent['data'] ?? ''
    );
  }
}
Future<String> fetchChat(userRequest) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.post(
      '$baseUrl/api/chat/recommend',
    data: {userRequest},
    options: Options(
      headers: {'Content-Type': 'text/plain'}, // Content-Type 헤더 설정
    ),
  );
  GPTchat temp = GPTchat.fromJson(response.data);
  return temp.data;
}