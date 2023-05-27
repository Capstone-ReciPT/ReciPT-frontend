import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Controller/TotalController.dart';
import 'package:recipt/Server/RecipeServer.dart';
import 'package:recipt/View/Other/RecipePage.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

var tipContent = [
  {'w': '1큰술\n(1T,1Ts)\n= 1숟가락','content' : '15ml = 3t\n(계량스푼이 없는 경우 밥숟가락으로 볼록하게 가득 담으면 1큰술)'},
  {'w': '1작은술(1t,1ts)','content' : '5ml\n(티스푼으로는 2스푼이 1작은술)'},
  {'w': '1컵(1Cup, 1C)','content' : '200ml = 16T\n(미국 및 서양의 경우 1C가 240~250ml이므로 계량컵 구매 사용시 주의'},
  {'w': '1종이컵','content' : '180ml'},
  {'w': '1oz','content' : '28.3g'},
  {'w': '1파운드(lb)','content' : '약 0.453 킬로그램(kg)'},
  {'w': '1갤런(gallon)','content' : '약 3.78 리터(l)'},
  {'w': '1꼬집','content' : '약 2g 정도이며 "약간" 이라고 표현하기도 함.'},
  {'w': '조금','content' : '약간의 2 ~ 3배'},
  {'w': '적당량','content' : '기호에 따라 마음대로 조절해서 넣으란 표현'},
  {'w': '1줌','content' : '한손 가득 넘치게 쥐어진 정도\n(예시 : 멸치 1줌 = 국멸치인 경우 12~15 마리, 나물 1줌은 50g'},
  {'w': '크게 1줌 = 2줌','content' : '1줌의 두배'},
  {'w': '1주먹','content' : '여자 어른의 주먹크기, 고기로는 100g'},
  {'w': '1토막','content' : '2~3cm 두께 정도의 분량'},
  {'w': '마늘 1톨','content' : '깐 마늘 한쪽'},
  {'w': '생강 1쪽','content' : '마늘 1톨의 크기와 비슷'},
  {'w': '생강 1톨','content' : '아기 손바닥만한 크기의 통생강 1개'},
  {'w': '고기 1근','content' : '600g'},
  {'w': '채소 1근','content' : '400g'},
  {'w': '채소 1봉지','content' : '200g 정도'},
];
class ProductItemScreen extends StatelessWidget {
  ProductItemScreen({this.id,Key? key}) : super(key: key);

  final id;
  final TotalController totalController = Get.put(TotalController());
  final SttController sttController = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RecipeDataInput>(
        future: fetchRecipe(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
                child: Scaffold(
                  body: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.network(snapshot.data!.data.thumbnailImage),
                      ),
                      buttonArrow(context),
                      scroll(snapshot),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: (){
                      sttController.context = snapshot.data!.data.context;
                      sttController.canShowFlag();
                      sttController.show();
                      Get.to(CookingMenu(id: id,));
                    },
                    child: Icon(Icons.navigate_next),
                  ),
                ));
          }
          else if (snapshot.hasError) {
            print(snapshot.error);
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
    );
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
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
                  Row(
                    children: [
                      Text(
                        snapshot.data!.data.foodName,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          IconButton(
                            onPressed: (){
                            },
                            icon: Icon(Icons.message,size: 30,),
                          ),
                          Text(
                            "후기",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: mainText),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 8,),
                          const LikeButton(),
                          SizedBox(height: 10,),
                          Text(
                            "좋아요 273",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: mainText),
                          ),
                        ],
                      )

                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "재료",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                              builder: (BuildContext context) {
                                return IngreTip();
                              }
                          );
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.help,color: Colors.black,),
                              SizedBox(width: 8,),
                              Text('계랑',style: Theme.of(context).textTheme.displaySmall,)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.data.ingredient.length,
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
                    itemCount: snapshot.data!.data.context.length,
                    itemBuilder: (context, index) => steps(context, index,snapshot),
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
            snapshot.data!.data.ingredient[index],
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  steps(BuildContext context, int index,snapshot) {
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
                      snapshot.data!.data.context[index],
                      maxLines: 3,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: mainText),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  index >= snapshot.data!.data.image.length
                  ? Image.network(
                    'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    height: 200,
                    width: 300,
                  ) : Image.network(
                    snapshot.data!.data.image[index],
                    height: 200,
                    width: 300,
                  )
                ],
              )
          ),

        ],
      ),
    );
  }
}


class IngreTip extends StatelessWidget {
  const IngreTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 200,
        height: 500,
        child: ListView.builder(
          itemCount: tipContent.length,
          itemBuilder: (context, index) {
            return Container(
                decoration: BoxDecoration(border: Border(
                    bottom: BorderSide(
                      color: Colors.grey, width: 1,
                    )
                )),
                margin: EdgeInsets.only(bottom: 10),
                child: TextButton(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(tipContent[index]['w']!,style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black),),
                      ),
                      SizedBox(width: 24,),
                      Container(height: 40, child: VerticalDivider(color: Colors.black,width: 2,)),
                      SizedBox(width: 24,),
                      Flexible(
                        child: Text(tipContent[index]['content']!,style: TextStyle(color: Colors.grey,fontSize: 13,fontWeight: FontWeight.w600),),
                      ),
                    ],
                  ),
                  onPressed: (){
                  },
                )
            );
          },
        ),
      ),
    );

  }
}


