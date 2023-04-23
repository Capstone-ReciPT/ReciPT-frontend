import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/RecipePage/Category.dart';
import 'package:recipt/main.dart';
import 'package:recipt/Recipe_on/RecipePage.dart';

import 'package:flutter_svg/flutter_svg.dart';
var foodList = {
  {'name' : '비빔밥', 'path':'assets/bibim.jpg'},
  {'name' : '스파게티 카르보나라', 'path':'assets/spageti.jpg'},
  {'name' : '라면', 'path':'assets/ramyun.jpg'},
};


class HomeBanner extends StatelessWidget {
  HomeBanner({Key? key}) : super(key: key);

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100,
        autoPlay: false,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          controller.changeBannerIndex(index);
        },
      ),
      items: foodList.map((data) {
        return Builder(builder: (BuildContext context){
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/Banner/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 15,
                right: 15,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Obx(() => Text(
                      "${controller.bannerIndex.value+1} / 3",
                      style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w800),
                    ),)
                  ),
                )
              )
            ],
          );
        }
        );
      }).toList(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container( margin: EdgeInsets.only(top: 20,bottom: 20), child: HomeBanner()),
        MainButtons(),
        PopularRecipe(),
      ]
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
        TextButton(onPressed: (){}, child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/refrigerator.svg',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8,),
            Text('냉장고\n파먹기',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
          ],
        )),TextButton(onPressed: (){}, child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/today.svg',
              width: 60,
              height: 50,
            ),
            SizedBox(height: 8,),
            Text('오늘\n뭐먹지',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
          ],
        )),TextButton(onPressed: (){}, child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/writing.svg',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8,),
            Text('레시피\n쓰기',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
          ],
        )),TextButton(onPressed: (){}, child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/review.svg',
              width: 50,
              height: 50,
            ),
            SizedBox(height: 8,),
            Text('리뷰\n작성',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
          ],
        )),
      ],
    );
  }
}

class PopularRecipe extends StatelessWidget {
  PopularRecipe({Key? key}) : super(key: key);

  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: EdgeInsets.only(top: 40,left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('인기 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
              TextButton(
                  onPressed: (){
                    Get.to(CategoryClick());
                  },
                  child: Text('See all',style: TextStyle(color: Colors.orange),)),
            ],
          ),
        CarouselSlider(
          options: CarouselOptions(
            height: 300,
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
                        Get.to(Ingredient());
                        return;
                      },
                      child: Image.asset(data['path'] ?? '',width:400,height: 220,fit: BoxFit.fill),
                    ),
                    Container(margin: EdgeInsets.only(top: 10),child: Text(data['name']?? '3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              );
            });
          }).toList(),
        ),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('오늘의 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
              TextButton(
                  onPressed: (){
                    Get.to(CategoryClick());
                  },
                  child: Text('See all',style: TextStyle(color: Colors.orange),)),
            ],
          ),
          TodayRecipe(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('새로운 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
              TextButton(
                  onPressed: (){
                    Get.to(CategoryClick());
                  },
                  child: Text('See all',style: TextStyle(color: Colors.orange),)),
            ],
          ),
          NewRecipe(),
    ])
    );
  }
}

class TodayRecipe extends StatelessWidget {
  const TodayRecipe({Key? key}) : super(key: key);

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
                child: Image.asset(
                  'assets/Banner/banner.png',
                  fit: BoxFit.fill,
                  // : TODO 이거 폰마다 맞는지 테스트
                  height: 200,
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10),child: Text('예시',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
            ],
          ),
        );
      }),
    );
  }
}

class NewRecipe extends StatelessWidget {
  const NewRecipe({Key? key}) : super(key: key);

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
                child: Image.asset(
                  'assets/Banner/banner.png',
                  fit: BoxFit.fill,
                  // : TODO 이거 폰마다 맞는지 테스트
                  height: 200,
                ),
              ),
              Container(margin: EdgeInsets.only(top: 10),child: Text('예시',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
            ],
          ),
        );
      }),
    );
  }
}



