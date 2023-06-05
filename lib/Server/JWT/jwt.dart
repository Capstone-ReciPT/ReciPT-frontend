import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeJwt(String jwt) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', jwt);
}

Future<String> getJwt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt') ?? '';
}