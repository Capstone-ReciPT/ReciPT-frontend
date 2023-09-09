import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/GPTRecipeServer.dart';
import 'package:recipt/Server/RecipeServer.dart';
import 'package:recipt/View/Other/Ingredient.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:flutter_gif/flutter_gif.dart';


class CookingMenu extends StatefulWidget {
  CookingMenu({required this.id,Key? key}) : super(key: key);

  final id;
  @override
  State<CookingMenu> createState() => _CookingMenuState();
}

class _CookingMenuState extends State<CookingMenu>{

  final CookingMenuController menuController = Get.find();
  final TtsController ttsController = Get.find();
  final SttController sttController = Get.find();

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
                    sttController.cantShowFlag();
                    menuController.index.value = 0;
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
      child: FutureBuilder<RecipeDataInput>(
          future: fetchRecipe(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  centerTitle: true,
                  title: Obx(() => Text('Step ${menuController.index.value+1}/${snapshot.data!.data.context.length}',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black))),
                  actions: [
                    IconButton(onPressed: (){
                      Get.to(MyApp());
                      menuController.index.value = 0;
                      sttController.cantShowFlag();
                    }, icon: Icon(Icons.close),color: Colors.black,)
                  ],
                ),
                body: FutureBuilder<RecipeDataInput>(
                    future: fetchRecipe(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() =>
                              menuController.index.value >= snapshot.data!.data.context.length-1
                                  ? Image.network('https://previews.123rf.com/images/urfingus/urfingus1406/urfingus140600001/29322328-%EC%A0%91%EC%8B%9C%EC%99%80-%ED%8F%AC%ED%81%AC%EC%99%80-%EC%B9%BC%EC%9D%84-%EB%93%A4%EA%B3%A0-%EC%86%90%EC%9D%84-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD%EC%97%90-%EA%B3%A0%EB%A6%BD.jpg',width: 300,height: 200,)
                                  : Image.network(snapshot.data!.data.image[menuController.index.value],fit: BoxFit.fill,width: 300,height: 200,)
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                ),
                                padding: EdgeInsets.only(left: 20,right: 20),
                                margin: EdgeInsets.only(top: 30),
                                width: 400,
                                height: snapshot.data!.data.context[menuController.index.value].length < 40
                                    ? 150
                                    : 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx(() => Text(snapshot.data!.data.context[menuController.index.value],style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 19))),
                                  ],
                                ),
                              ),
                              SizedBox(height: 100,),
                              // 현재 에러가 나는 부분
                              Obx(() => Visibility(
                                visible: sttController.nowListen.value, // 조건에 따라 표시 여부 설정
                                child: Container(
                                    width: 250,
                                    height: 150,
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
                      else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
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
                            if(menuController.index.value > 0){
                              menuController.pageLimit = snapshot.data!.data.context.length;
                              menuController.prevIndex();
                            } else {
                              sttController.cantShowFlag();
                              Get.to(ProductItemScreen(id: widget.id,));
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
                          if(menuController.index.value >= snapshot.data!.data.context.length){
                            menuController.pageLimit = snapshot.data!.data.context.length;
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
                            menuController.pageLimit = snapshot.data!.data.context.length;
                            // ttsController.speakText(text[menuController.index.value]);
                          }
                        },
                        child: Icon(Icons.navigate_next),
                        heroTag: 'Recipe',
                      ),
                    )
                  ],
                ),
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }
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
            Get.to(MyApp());
            menuController.index.value = 0;
          },
        ),
      ],
    );
  }
}


