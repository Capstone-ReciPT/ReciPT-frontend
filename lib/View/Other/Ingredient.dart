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