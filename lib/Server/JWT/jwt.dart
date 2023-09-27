import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

Future<void> checkJwtValidity(String jwt) async {
  Map<String, dynamic> decodedJwt = Jwt.parseJwt(jwt);

  if (decodedJwt != null) {
    // JWT를 해독하여 페이로드를 확인할 수 있습니다.
    print('JWT Payload: $decodedJwt');

    // 만료 시간을 확인합니다.
    if (decodedJwt.containsKey('exp')) {
      final int expirationTime = decodedJwt['exp'];
      final int currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      if (expirationTime > currentTime) {
        // JWT가 아직 유효합니다.
        print('JWT is valid.');
      } else {
        // JWT가 만료되었습니다.
        print('JWT has expired.');
      }
    } else {
      // 만료 시간이 없는 경우, 유효성을 확인할 수 없습니다.
      print('JWT does not contain an expiration time.');
    }
  } else {
    // JWT를 해독할 수 없는 경우, 유효성을 확인할 수 없습니다.
    print('JWT is invalid or could not be decoded.');
  }
}
Future<void> storeJwt(String jwt) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwt', jwt);
}

Future<String> getJwt() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jwt = prefs.getString('jwt') ?? '';
  jwt = jwt.replaceAll(new RegExp(r'[\[\]]'), '');  // 대괄호를 제거
  print(jwt);
  return jwt;
}
