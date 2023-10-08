
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';

Future<String> checkIssue() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();
  String refresh = await getRefresh();

  try{
    final response = await dio.post(
      '$baseUrl/api/reissue',
      options: Options(
        headers: {
          'Content-Type': 'text/plain',
          'accesToken': jwt,
          'refreshTOken' : refresh,
          'Authorization': 'Bearer $jwt',
        }, // Content-Type 헤더 설정
      ),
    );
    return jwt;
  } catch(e){
    print(e);
   print('에러남');
   return '';
  }
}