import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Server/GPTRecipeServer.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

class SelectedRecipe extends StatefulWidget {
  SelectedRecipe({required this.selectedFood,Key? key}) : super(key: key);

  final selectedFood;
  var gptRecipe;
  @override
  State<SelectedRecipe> createState() => _SelectedRecipeState();
}

class _SelectedRecipeState extends State<SelectedRecipe> {
  final SttController sttController = Get.find();

  bool canSttFlag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.gptRecipe = fetchGPTRecipe(widget.selectedFood);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GPTRecipe>(
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
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.green,
                    onPressed: (){
                      if (!canSttFlag){
                        sttController.context = snapshot.data!.context;
                        sttController.canShowFlag();
                        sttController.show();
                        setState(() {
                          canSttFlag = true;
                        });
                      } else {
                        sttController.cantShowFlag();
                        setState(() {
                          canSttFlag = false;
                        });
                      }
                    },
                    child: canSttFlag == true ? Icon(Icons.stop) : Icon(Icons.keyboard_voice)
                  ),
                  // floatingActionButton: FloatingActionButton(
                  //   onPressed: (){
                  //     // sttController.context = snapshot.data!.data.context;
                  //     sttController.canShowFlag();
                  //     sttController.show();
                  //     // Get.to(CookingMenu(id));
                  //   },
                  //   child: Icon(Icons.navigate_next),
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
                  CircularProgressIndicator()
                ],
              ),
            )
          );
        }
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

