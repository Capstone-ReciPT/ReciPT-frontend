import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final BoxFit? boxFit;

  MyImageLoader({required this.imageUrl, this.height, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: loadImage(imageUrl),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 이미지 로딩 중일 때는 CircularProgressIndicator를 표시합니다.
          return Container(
              width: 150,
              height: 80,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/icons/voice2.gif"),
                radius: 40.0,
              )
          );
        } else if (snapshot.hasError) {
          // 이미지 로딩에 실패한 경우, 에러 메시지를 표시합니다.
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');

        } else {
          // 이미지 로딩이 완료되면, 이미지를 표시합니다.
          return Image(
            image: snapshot.data!.image,
            fit: boxFit,
            height: height,
          );
        }
      },
    );
  }
}

Future<Image> loadImage(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    return Image.memory(
      await Future.value(response.bodyBytes),
    );
  } else {
    throw Exception('Failed to load image');
  }
}
