import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_parser/http_parser.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<bool> signUpFunc(id, pw,profileImage,age,username) async {
  final dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];
  FormData formData = FormData.fromMap({
    "profile": await MultipartFile.fromFile(profileImage.path, contentType: MediaType('image', 'png')),
    'username' : username,
    'age' : age,
    'loginId' : id,
    'password' : pw,
    'passwordConfirm' : pw
  });
  final response = await dio.post(
      '$baseUrl/api/signup',
    data: formData
  );

  return true;
}