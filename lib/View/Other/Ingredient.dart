import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Controller/TotalController.dart';
import 'package:recipt/View/Other/RecipePage.dart';
import 'package:recipt/constans/colors.dart';

class ProductItemScreen extends StatelessWidget {
  ProductItemScreen({Key? key}) : super(key: key);

  final TotalController totalController = Get.put(TotalController());
  final SttController sttController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset("assets/bibim.jpg"),
              ),
              buttonArrow(context),
              scroll(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              sttController.canShowFlag();
              sttController.show();
              Get.to(CookingMenu());
            },
            child: Icon(Icons.navigate_next),
          ),
        ));
  }

  buttonArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        onTap: () {
          Get.back();
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

  scroll() {
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
                  Text(
                    "맛있는 비빔밥 만들기",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                          AssetImage("assets/bibim.jpg"),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "손지석",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(color: mainText),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 4,
                    ),
                  ),
                  Text(
                    "설명",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: SecondaryText),
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
                    itemCount: 3,
                    itemBuilder: (context, index) => ingredients(context),
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
                    itemCount: 3,
                    itemBuilder: (context, index) => steps(context, index),
                  ),
                ],
              ),
            ),
          );
        });
  }

  ingredients(BuildContext context) {
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
            "고추장 1숟가락",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  steps(BuildContext context, int index) {
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
          Column(
            children: [
              SizedBox(
                width: 270,
                child: Text(
                  "가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하",
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
              Image.asset(
                "assets/bibim.jpg",
                height: 155,
                width: 270,
              )
            ],
          )
        ],
      ),
    );
  }
}