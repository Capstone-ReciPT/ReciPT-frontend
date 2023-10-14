import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/main.dart';

import 'RatingStar.dart';

class RecipeEndReview extends StatelessWidget {

  RecipeEndReview({this.registerFlag,Key? key}) : super(key: key);

  var registerFlag;
  final CookingMenuController menuController = Get.find();
  final TtsController ttsController = Get.find();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 300,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('요리는 즐겁게 하셨나요?',style: Theme.of(context).textTheme.displayMedium),
            Text('레시피에 대한 별점을 작성해주세요!',style: Theme.of(context).textTheme.displayMedium),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RatingStar(),
            ),
            SizedBox(height: 20,),
            // TextField(
            //   decoration: InputDecoration(
            //       hintText: '한줄 후기를 입력해주세요',
            //       border: OutlineInputBorder()
            //   ),
            // )
          ],
        ),
      ),
      insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
      actions: [
        TextButton(
          child: Text('취소'),
          onPressed: (){
            Get.back();
          },
        ),
        TextButton(
          child: Text('확인'),
          onPressed: () {
            Get.to(MyApp());
            ttsController.stopTTS();
            menuController.index.value = 0;

          },
        ),
      ],
    );
  }
}
