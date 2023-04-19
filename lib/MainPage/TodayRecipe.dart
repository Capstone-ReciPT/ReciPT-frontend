import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';
import 'package:recipt/Recipe_on/RecipePage.dart';


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
        onPageChanged: (index, reason) {
          controller.changeDotIndex(index);
        },
      ),
      items: foodList.map((data) {
        return Builder(builder: (BuildContext context){
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), //모서리를 둥글게
                border: Border.all(color: Colors.black12, width: 3), //테두리
            ),
            width: 400,
            height: 50,
            child: Column(
              children: [

              ],
            ),
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
            Icon(Icons.camera_alt_outlined,size: 50,),
            Text('냉장고\n파먹기',textAlign: TextAlign.center),
          ],
        )),TextButton(onPressed: (){}, child: Column(
          children: [
            Icon(Icons.camera_alt_outlined,size: 50,),
            Text('오늘\n뭐먹지',textAlign: TextAlign.center),
          ],
        )),TextButton(onPressed: (){}, child: Column(
          children: [
            Icon(Icons.camera_alt_outlined,size: 50,),
            Text('레시피\n쓰기',textAlign: TextAlign.center),
          ],
        )),TextButton(onPressed: (){}, child: Column(
          children: [
            Icon(Icons.camera_alt_outlined,size: 50,),
            Text('리뷰\n작성',textAlign: TextAlign.center),
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
      margin: EdgeInsets.only(top: 20,left: 10,right: 10),
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
              TextButton(onPressed: (){}, child: Text('See all',)),
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
                    Image.asset(data['path'] ?? '',width:400,height: 220,fit: BoxFit.fill),
                    Container(margin: EdgeInsets.only(top: 10),child: Text(data['name']?? '3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              );
            });
          }).toList(),
        ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('오늘의 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
              TextButton(onPressed: (){}, child: Text('See all',)),
            ],
          ),
          TodayRecipe(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.ideographic,
            children: [
              Text('새로운 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800),),
              TextButton(onPressed: (){}, child: Text('See all',)),
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
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodList.length, itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Card(
            color: Colors.blue,
            child: Container(
              child: Center(child: Text('1', style: TextStyle(color: Colors.white, fontSize: 36.0),)),
            ),
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
      height: MediaQuery.of(context).size.height * 0.35,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: foodList.length, itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Card(
            color: Colors.blue,
            child: Container(
              child: Center(child: Text('1', style: TextStyle(color: Colors.white, fontSize: 36.0),)),
            ),
          ),
        );
      }),
    );;
  }
}



