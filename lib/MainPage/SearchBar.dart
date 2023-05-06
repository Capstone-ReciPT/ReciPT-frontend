import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_history_text_field/input_history_text_field.dart';


class InputHistoryController2 extends GetxController{
  var searchList = ['flutter','hi'].obs;
}
class SearchBarMain extends StatelessWidget {
  SearchBarMain({Key? key}) : super(key: key);

  final InputHistoryController2 controller = Get.put(InputHistoryController2());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          children: [
            InputHistoryTextField(
              limit: 5,
              historyKey: "01",
              listStyle: ListStyle.Badge,
              onEditingComplete: (){},

            ),
          ],
        ),
      ),
    );
  }
}
