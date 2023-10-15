import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/JWT/jwt.dart';

Future<bool> fetchLike(int id,double score) async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  String jwt = await getJwt();
  final response = await dio.post('$baseUrl/api/register/update/score/$id',
    data: {
      'inputRatingScore': score,  // 키 'score'와 값을 추가하였습니다.
    },
    options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
        'accessToken': jwt,
      }, // Content-Type 헤더 설정
    ),
  );

  if(response.data == null ||response.data['code'] == 500){
    final response = await dio.post('$baseUrl/api/db/update/score/$id',
      data: {
        'inputRatingScore': score,  // 키 'score'와 값을 추가하였습니다.
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwt',
          'accessToken': jwt,
        }, // Content-Type 헤더 설정
      ),
    );
  }

  print(response.data);

  return true;
}