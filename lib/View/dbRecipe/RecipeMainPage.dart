import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/gpt/GPTRecipeServer.dart';
import 'package:recipt/Server/RecipeServer.dart';
import 'package:recipt/View/dbRecipe/Ingredient.dart';
import 'package:recipt/View/dbRecipe/RecipeEndReview.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:flutter_gif/flutter_gif.dart';

import 'RatingStar.dart';


class RecipeMainPage extends StatefulWidget {
  RecipeMainPage({required this.id,Key? key}) : super(key: key);

  final id;
  @override
  State<RecipeMainPage> createState() => _RecipeMainPageState();
}

class _RecipeMainPageState extends State<RecipeMainPage>{

  final CookingMenuController menuController = Get.find();
  final TtsController ttsController = Get.find();
  var playNow = false;

  Future<bool> onBackKeyRecipe(BuildContext context) async {

    print(menuController.index.value);
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFFFFFF),
            title: Text(
              '레시피를 종료하시겠습니까?',
              style: TextStyle(color: mainText,fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    menuController.index.value = 0;
                    ttsController.stopTTS();
                    Get.offAll(MyApp());
                  },
                  child: Text('끝내기',style: TextStyle(color: SecondaryText),)),
              TextButton(
                  onPressed: () {
                    //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                    Navigator.of(context).pop(false); // 대화 상자 닫기
                  },
                  child: Text('아니요',style: TextStyle(color: SecondaryText),)),
            ],
          );
        }) ?? false; // 취소 버튼이 눌릴 경우 false 반환
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onBackKeyRecipe(context),
      child: FutureBuilder<RecipeDataInputFlag>(
          future: fetchRecipe(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Obx(() => Text('Step ${menuController.index.value+1}/${snapshot.data!.recipeDataInput.data.context.length}',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black))),
                  actions: [
                    IconButton(onPressed: (){
                      ttsController.stopTTS();
                      menuController.index.value = 0;
                      Get.offAll(MyApp());
                    }, icon: Icon(Icons.close),color: Colors.black,)
                  ],
                ),
                body: FutureBuilder<RecipeDataInputFlag>(
                    future: fetchRecipe(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!.registerFlag){
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() =>
                                menuController.index.value > snapshot.data!.recipeDataInput.data.context.length
                                    ? Image.network('https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',width: 300,height: 200,)
                                    : Image(
                                        image : MemoryImage(snapshot.data!.recipeDataInput.data.imageByte![menuController.index.value]),fit: BoxFit.fill,width: 300,height: 200,
                                      )
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                  ),
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  margin: EdgeInsets.only(top: 30),
                                  width: 400,
                                  height: snapshot.data!.recipeDataInput.data.context[menuController.index.value].length < 40
                                      ? 150
                                      : 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() => Text(snapshot.data!.recipeDataInput.data.context[menuController.index.value],style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 19))),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 50,),
                                Obx(() => Visibility(
                                  visible: ttsController.speakNow.value , // 조건에 따라 표시 여부 설정
                                  child: Container(
                                      width: 150,
                                      height: 80,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("assets/icons/voice2.gif"),
                                        radius: 40.0,
                                      )
                                  ),
                                ))
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() =>
                                menuController.index.value > snapshot.data!.recipeDataInput.data.context.length-1
                                    ? Image.network('https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',width: 300,height: 200,)
                                    : Image.network(snapshot.data!.recipeDataInput.data.image![menuController.index.value],fit: BoxFit.fill,width: 300,height: 200,)
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                  ),
                                  padding: EdgeInsets.only(left: 20,right: 20),
                                  margin: EdgeInsets.only(top: 30),
                                  width: 400,
                                  height: snapshot.data!.recipeDataInput.data.context[menuController.index.value].length < 40
                                      ? 150
                                      : 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() => Text(snapshot.data!.recipeDataInput.data.context[menuController.index.value],style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 19))),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 50,),
                                Obx(() => Visibility(
                                  visible: ttsController.speakNow.value , // 조건에 따라 표시 여부 설정
                                  child: Container(
                                      width: 150,
                                      height: 80,
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage("assets/icons/voice2.gif"),
                                        radius: 40.0,
                                      )
                                  ),
                                ))
                              ],
                            ),
                          );
                        }
                      }
                      else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text("${snapshot.error}");
                      }
                      return Center(
                        child: Container(
                            width: 150,
                            height: 80,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/icons/voice2.gif"),
                              radius: 40.0,
                            )
                        ),
                      );
                    }
                ),
                floatingActionButton: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: FloatingActionButton(
                          onPressed: (){
                            if (playNow){
                              ttsController.stopTTS();
                            }
                            if(menuController.index.value > 0){
                              menuController.pageLimit = snapshot.data!.recipeDataInput.data.context.length;
                              menuController.prevIndex();
                            } else {
                              Get.to(ProductItemScreen(id: widget.id,));
                            }
                          },
                          heroTag: 'prev',
                          child: Icon(Icons.chevron_left),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          onPressed: () async {
                            if (playNow){
                              ttsController.stopTTS();
                            } else{
                              setState(() {
                                playNow = !playNow;
                              });
                              await ttsController.speakText(snapshot.data!.recipeDataInput.data.context[menuController.index.value])
                                  .then((value) => setState((){
                                playNow = !playNow;
                              }));
                            }
                          },
                          heroTag: 'play',
                          child: playNow == true ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        onPressed: () async{
                          if(playNow){
                            ttsController.stopTTS();
                          }
                          menuController.nextIndex();
                          if(menuController.index.value >= snapshot.data!.recipeDataInput.data.context.length){
                            menuController.pageLimit = snapshot.data!.recipeDataInput.data.context.length;
                            menuController.fixIndex();
                            showDialog(
                                context: context,
                                barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                                builder: (BuildContext context) {
                                  return RecipeEndReview(
                                      registerFlag : snapshot.data?.registerFlag,
                                      id : snapshot.data?.registerFlag == true
                                        ? snapshot.data?.recipeDataInput.data.registerRecipeId
                                          : snapshot.data?.recipeDataInput.data.recipeId
                                  );
                                }
                            );
                          } else {
                            menuController.pageLimit = snapshot.data!.recipeDataInput.data.context.length;
                            // ttsController.speakText(text[menuController.index.value]);
                          }
                        },
                        child: Icon(Icons.navigate_next),
                        heroTag: 'next',
                      ),
                    )
                  ],
                ),
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            } else{
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('레시피를 로딩중입니다!',style: Theme.of(context).textTheme.displayLarge),
                    Text('잠시만 기다려주세요',style: Theme.of(context).textTheme.displayLarge),
                    SizedBox(height: 20,),
                    Container(
                        width: 150,
                        height: 80,
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/icons/voice2.gif"),
                          radius: 40.0,
                        )
                    )
                  ],
                ),
              );
            }
          }
      ),
    );
  }
}

