import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/ImageController.dart';
import 'package:recipt/View/BNB/Category.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/View/Other/RecipePage.dart';
import 'package:like_button/like_button.dart';
import 'package:recipt/Widget/Like_button.dart';
import 'package:recipt/constans/colors.dart';

import '../Other/Ingredient.dart';
var foodList = {
  {'name' : '비빔밥', 'path':'assets/bibim.jpg'},
  {'name' : '스파게티 카르보나라', 'path':'assets/spageti.jpg'},
  {'name' : '라면', 'path':'assets/ramyun.jpg'},
};


class PopularRecipe extends StatelessWidget {
  PopularRecipe({Key? key}) : super(key: key);

  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text('인기 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: mainText),),
            TextButton(
                onPressed: (){
                  Get.to(CategoryClick());
                },
                child: Text('See all',style: TextStyle(color: Colors.orange),)),
          ],
        ),
      CarouselSlider(
        options: CarouselOptions(
          height: 310,
          autoPlay: false,
          viewportFraction: 1,
          onPageChanged: (index, reason) {
            controller.changeDotIndex(index);
          },
        ),
        items: foodList.map((data) {
          return Builder(builder: (BuildContext context){
            return Container(
              margin: EdgeInsets.only(top: 15,bottom: 5),
              width: 400,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(ProductItemScreen());
                      return;
                    },
                    child: Stack(
                      children: [
                        Image.asset(data['path'] ?? '',width:400,height: 220,fit: BoxFit.fill),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: LikeButtonWidget(),
                        )
                      ],
                    ),
                  ),
                  Container(margin: EdgeInsets.only(top: 10),child: Text(data['name']?? '3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
                ],
              ),
            );
          });
        }).toList(),
      ),
    ]);
  }
}
class TodayRecipeNotice extends StatelessWidget {
  const TodayRecipeNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text('오늘의 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: mainText),),
        TextButton(
            onPressed: (){
              Get.to(CategoryClick());
            },
            child: Text('See all',style: TextStyle(color: Colors.orange),)),
      ],
    );
  }
}

class TodayRecipe extends StatelessWidget {
  TodayRecipe({Key? key}) : super(key: key);

  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: 325,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodList.length, itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.only(right: 50),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Image.asset('assets/Banner/banner.png',fit: BoxFit.fill,height: 200,),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: LikeButtonWidget(),
                    )
                  ],
                )
              ),
              Container(margin: EdgeInsets.only(top: 10),child: Text('예시',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
            ],
          ),
        );
      }),
    );
  }
}

class NewRecipeNotice extends StatelessWidget {
  const NewRecipeNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text('새로운 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: mainText),),
        TextButton(
            onPressed: (){
              Get.to(CategoryClick());
            },
            child: Text('See all',style: TextStyle(color: Colors.orange),)),
      ],
    );
  }
}

class NewRecipe extends StatelessWidget {
  NewRecipe({Key? key}) : super(key: key);

  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: 325,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodList.length, itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          margin: EdgeInsets.only(right: 50),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/Banner/banner.png',
                      fit: BoxFit.fill,
                      // : TODO 이거 폰마다 맞는지 테스트
                      height: 200,
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: LikeButtonWidget(),
                    )
                  ],
                )
              ),
              Container(margin: EdgeInsets.only(top: 10),child: Text('예시',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
            ],
          ),
        );
      }),
    );
  }
}



