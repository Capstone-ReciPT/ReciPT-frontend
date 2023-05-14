import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();


}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: () async{
          await printMessage();
        },
        child: Text('클릭'),
      ),
    );
  }

  printMessage() async{
    Uri uri = Uri.parse('http://10.0.2.2:8080/api/test/connect');
    print(uri);
    final response = await http.get(uri);
    var res;
    res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      res = jsonDecode(response.body);
      print(res);
      return res;
    } else{
      print(response.statusCode);
    }

    print(res);
    return res;
  }
}

