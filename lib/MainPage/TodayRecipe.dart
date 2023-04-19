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
                borderRadius: BorderRadius.circular(50), //모서리를 둥글게
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

