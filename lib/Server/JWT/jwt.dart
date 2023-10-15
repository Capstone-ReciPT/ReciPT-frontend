import 'package:shared_preferences/shared_preferences.dart';
Future<void> storeJwt(String accessToken, String refreshToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', accessToken);
  await prefs.setString('refresh', refreshToken);
}

Future<String> getJwt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt') ?? '';
  jwt = jwt.replaceAll(new RegExp(r'[\[\]]'), '');  // 대괄호를 제거
  print(jwt);
  return jwt;
}

Future<String> getRefresh() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String refresh = prefs.getString('refresh') ?? '';
  refresh = refresh.replaceAll(new RegExp(r'[\[\]]'), '');  // 대괄호를 제거
  print(refresh);
  return refresh;
}

Future<void> removeJwt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', '');
  await prefs.setString('refresh', '');
}



