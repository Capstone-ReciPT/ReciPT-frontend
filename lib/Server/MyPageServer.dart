import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recipt/Server/CategoryServer.dart';

class MypageUser{
  final int userId;
  final String username;
  final String profileData;

  MypageUser(this.userId, this.username, this.profileData);

  factory MypageUser.fromJson(Map<String, dynamic> mainContent) {
    return MypageUser(
      mainContent['userId'],
      mainContent['username'],
      mainContent['profileData'] ?? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
    );
  }


}
Future<MypageUser> fetchUser() async{
  String? baseUrl = dotenv.env['BASE_URL'];
  final dio = Dio();
  final response = await dio.get('$baseUrl/api/category');
  return MypageUser.fromJson(response.data['data']);
}
