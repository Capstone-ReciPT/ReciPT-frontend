import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Server/gpt/GPTRecipeServer.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

import '../../Server/search/GptNoRecipe.dart';

class gptNoRecipe extends StatefulWidget {
  gptNoRecipe({required this.selectedFood,Key? key}) : super(key: key);

  final selectedFood;
  var gptRecipe;
  @override
  State<gptNoRecipe> createState() => _gptNoRecipeState();
}

class _gptNoRecipeState extends State<gptNoRecipe> {

  bool canSttFlag = false;

  Future<bool> onBackKeyGPTRecipe(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFFFFFF),
            title: Text(
              'GPT 레시피를 종료하시겠습니까?',
              style: TextStyle(color: mainText,fontSize: 18),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    //onWillpop에 true가 전달되어 앱이 종료 된다.
                    fetchGPTRefresh();
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
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.gptRecipe = fetchGPTNoRecipe(widget.selectedFood);
  }
  @override
  Widget build(BuildContext context) {
    print(widget.selectedFood);
    return WillPopScope(
      onWillPop: () => onBackKeyGPTRecipe(context),
      child: FutureBuilder<GPTRecipe>(
          future: widget.gptRecipe,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset('assets/icons/ChatGPT_logo.png'),
                      ),
                      buttonArrow(context),
                      scroll(snapshot),
                    ],
                  ),
                  // floatingActionButton: FloatingActionButton(
                  //     backgroundColor: Colors.green,
                  //     onPressed: (){
                  //       if (!canSttFlag){
                  //         sttController.context = snapshot.data!.context;
                  //         sttController.canShowFlag();
                  //         sttController.show();
                  //         setState(() {
                  //           canSttFlag = true;
                  //         });
                  //       } else {
                  //         sttController.cantShowFlag();
                  //         setState(() {
                  //           canSttFlag = false;
                  //         });
                  //       }
                  //     },
                  //     child: canSttFlag == true ? Icon(Icons.stop) : Icon(Icons.keyboard_voice)
                  // ),
                ),
              );
            }
            else if (snapshot.hasError) {
              print(snapshot.error);
              return Text("${snapshot.error}");
            }
            return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/ChatGPT_logo.png',width: 120,),
                      SizedBox(height: 20,),
                      Text('GPT가 레시피를 생성중입니다!',style: Theme.of(context).textTheme.displayLarge),
                      Text('잠시만 기다려주세요',style: Theme.of(context).textTheme.displayLarge),
                      SizedBox(height: 20,),
                      Container(
                          width: 150,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/icons/voice2.gif"),
                            radius: 40.0,
                          )
                      ),
                    ],
                  ),
                )
            );
          }
      ),
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          fetchGPTRefresh();
          Get.to(MyApp());
        },
        child: Container(
          clipBehavior: Clip.hardEdge,
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.black45
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  scroll(snapshot) {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 35,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "재료",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.ingredient.length,
                    itemBuilder: (context, index) => ingredients(context,snapshot,index),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "레시피",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.context.length,
                    itemBuilder: (context, index) => steps(context, snapshot,index),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context,snapshot,index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 10,
            backgroundColor: Color(0xFFE3FFF8),
            child: Icon(
              Icons.done,
              size: 15,
              color: primary,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            snapshot.data!.ingredient[index],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  steps(BuildContext context, snapshot ,int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: mainText,
            radius: 12,
            child: Text("${index + 1}"),
          ),
          Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 270,
                    child: Text(
                      snapshot.data!.context[index],
                      maxLines: 3,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: mainText),
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }
}

