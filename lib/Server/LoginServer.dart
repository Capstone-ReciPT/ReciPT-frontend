import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';



Future<String> signUpFunc(id, pw,profileImage,age,username) async {
  final dio = Dio();
  FormData formData = FormData.fromMap({
    "profile": await MultipartFile.fromFile(profileImage.path, contentType: MediaType('image', 'png')),
    'username' : username,
    'age' : age,
    'loginId' : id,
    'password' : pw,
    'passwordConfirm' : pw
  });
  final response = await dio.post(
      'http://10.0.2.2:8080/api/signup',
    data: formData
  );
  print(response);

  return '성공';
}