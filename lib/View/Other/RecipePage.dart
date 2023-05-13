import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/View/Other/Ingredient.dart';
import 'package:recipt/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipt/Controller/PageController.dart';

class CookingMenu extends StatelessWidget {

  CookingMenu({Key? key}) : super(key: key);

  final CookingMenuController menuController = Get.find();
  final TtsController ttsController = Get.find();
  final SttController sttController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Obx(() => Text('Step ${menuController.index.value+1}/${text.length}',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black))),
        actions: [
          IconButton(onPressed: (){
            Get.offAll(ProductItemScreen());
            menuController.index.value = 0;
            sttController.cantShowFlag();
            }, icon: Icon(Icons.close),color: Colors.black,)
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/bibim.jpg'),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              margin: EdgeInsets.only(top: 30),
              width: 400,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(() => Text(text[menuController.index.value],style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
            Obx(() => Text(sttController.text1.value)),
            Obx(() => Text(sttController.text2.value)),
          ],
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: EdgeInsets.only(left: 30),
              child: FloatingActionButton(
                onPressed: (){
                  if(menuController.index.value > 0){
                    menuController.prevIndex();
                  } else {
                    sttController.cantShowFlag();
                    Get.offAll(ProductItemScreen());
                  }
                },
                child: Icon(Icons.chevron_left),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: (){
                menuController.nextIndex();
                if(menuController.index.value >= text.length){
                  menuController.fixIndex();
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return ReviewDialog();
                      }
                  );
                  sttController.cantShowFlag();
                } else {
                  // ttsController.speakText(text[menuController.index.value]);
                }
              },
              child: Icon(Icons.navigate_next),
            ),
          )
        ],
      ),
    );
  }
}



class RatingStar extends StatelessWidget {
  const RatingStar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        size: 24,
        color: Colors.blueGrey,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}

class ReviewDialog extends StatelessWidget {
  ReviewDialog({Key? key}) : super(key: key);

  final SttController sttController = Get.find();
  final CookingMenuController menuController = Get.find();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 210,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('요리는 즐겁게 하셨나요? \n레시피에 대한 별점을 작성해주세요!',style: TextStyle(fontSize: 20)),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RatingStar(),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                hintText: '한줄 후기를 입력해주세요',
                border: OutlineInputBorder()
              ),
            )
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
            sttController.cantShowFlag();
            Get.offAll(()=> MyApp());
            menuController.index.value = 0;
          },
        ),
      ],
    );
  }
}


