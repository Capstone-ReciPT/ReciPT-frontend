import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';

var image2 = [
  "assets/img.jpg",
  "assets/img-1.jpg",
  "assets/img-2.jpg",
  "assets/img-3.jpg",
  "assets/img-4.jpg",
  "assets/img-5.jpg",
  "assets/img-6.jpg",
  "assets/img-7.jpg",
  "assets/op.jpg",
];


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
      items: image2.map((i) {
        return Builder(builder: (BuildContext context){
          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            width: 500,
            height: 200,
            child: Column(
              children: [
                Text('@ 만들기', style: TextStyle(fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category),
                    Text('볶음/구이'),
                  ],
                ),
                Expanded(child: Image.asset(i)),
                Obx(() => DotsIndicator(
                  dotsCount: image2.length,
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

