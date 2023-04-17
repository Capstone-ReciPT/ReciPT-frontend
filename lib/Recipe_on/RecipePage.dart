import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';
import 'package:recipt/RecipePage/Category.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

var text = [
  '떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.',
  '떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.2',
  '떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.3',
];

class CookingMenuController extends GetxController{
  stt.SpeechToText speech = stt.SpeechToText();
  final FlutterTts tts = FlutterTts();
  var index = 0.obs;
  void speakText(String text) async{
    await tts.setLanguage('ko-KR');
    await tts.setSpeechRate(0.4);
    await tts.speak(text);
  }

  nextIndex(){
    index++;
    update();
  }

  prevIndex(){
    index--;
    update();
  }

  fixIndex(){
    index.value = text.length-1;
  }
}

class Ingredient extends StatelessWidget {
  Ingredient({Key? key}) : super(key: key);
  final CookingMenuController controller = Get.put(CookingMenuController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('비빔밥 만들기',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('고추장 1숟가락')
                  ],
                )
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            controller.speakText(text[controller.index.value]);
            Get.to(CookingMenu());
          },
          child: Icon(Icons.navigate_next),
        ),
    );
  }
}

class CookingMenu extends StatelessWidget {

  CookingMenu({Key? key}) : super(key: key);

  final CookingMenuController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Obx(() => Text('Step ${controller.index.value+1}/${text.length}',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black))),
        actions: [
          IconButton(onPressed: (){Get.back(); controller.index.value = 0;}, icon: Icon(Icons.close),color: Colors.black,)
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
                  Obx(() => Text(text[controller.index.value],style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
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
                  if(controller.index.value > 0){
                    controller.prevIndex();
                    controller.speakText(text[controller.index.value]);
                  } else {
                    Get.back();
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
                controller.nextIndex();
                if(controller.index.value >= text.length){
                  controller.fixIndex();
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 130,
                            child: Column(
                              children: [
                                Text('요리는 즐겁게 하셨나요? \n레시피에 대한 별점을 작성해주세요!',style: TextStyle(fontSize: 20)),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: RatingStar(),
                                ),
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
                                Get.back();
                                controller.index.value = 0;
                              },
                            ),
                          ],
                        );
                      }
                  );
                } else {
                  controller.speakText(text[controller.index.value]);
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


