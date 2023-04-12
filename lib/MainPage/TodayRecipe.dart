import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';


var foodList = {
  {'name' : '비빔밥', 'path':'assets/bibim.jpg'},
  {'name' : '스파게티 카르보나라', 'path':'assets/spageti.jpg'},
  {'name' : '라면', 'path':'assets/ramyun.jpg'},
};


class SlidePage extends StatelessWidget {
  SlidePage({Key? key}) : super(key: key);

  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        onPageChanged: (index, reason) {
          controller.changeDotIndex(index);
        },
      ),
      items: foodList.map((data) {
        return Builder(builder: (BuildContext context){
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            width: 500,
            height: 200,
            child: Column(
              children: [
                Text('${data['name']} 만들기', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category),
                    Text('볶음/구이'),
                  ],
                ),
                Expanded(child: Image.asset(data['path']!)),
                Obx(() => DotsIndicator(
                  dotsCount: foodList.length,
                  position: controller.currentDotIndex.value.toDouble(),
                )),
              ],
            ),
          );
        }
        );
      }).toList(),
    );
  }
}

