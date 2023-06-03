import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/View/BNB/Home/MainPresentRecipes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipt/View/BNB/Mypage.dart';
import 'package:recipt/View/BNB/Yolo/RecipeRecommend.dart';
import 'package:recipt/View/BNB/Yolo/TodayWhat.dart';
import 'package:recipt/View/Other/UploadCoverAndDes.dart';
import 'package:recipt/Widget/Custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400,
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Column(
            children: [
              ButtonToSearchTab(),
              SizedBox(height: 10,),
              // Container( margin: EdgeInsets.only(top: 10,bottom: 20), child: HomeBanner()),
              MainButtons(),
              SizedBox(height: 20,),
              PopularRecipe(),
              TodayRecipeNotice(),
              TodayRecipe(),
              NewRecipeNotice(),
              NewRecipe(),
            ]
        ),
      ),
    );
  }
}


class MainButtons extends StatelessWidget {
  const MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: (){
              Get.to(YoloImage());
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/refrigerator.svg',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8,),
                Text('냉장고\n파먹기',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
              ],
            )
        ),
        TextButton(onPressed: (){
          Get.to(TodayWhat());
        }, child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/today.svg',
              width: 60,
              height: 50,
            ),
            SizedBox(height: 8,),
            Text('오늘\n뭐먹지',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
          ],
        )),TextButton(
            onPressed: (){
              Get.to(UploadTab());
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/writing.svg',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8,),
                Text('레시피\n쓰기',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            )
        ),
        TextButton(
            onPressed: (){
              Get.to(Setting());
            },
            child: Column(
              children: [
                Icon(Icons.settings,size: 50,color: Colors.black,),
                SizedBox(height: 10,),
                Text('설정',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,),),
              ],
            )
        ),
      ],
    );
  }
}