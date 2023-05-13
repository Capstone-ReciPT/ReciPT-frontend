import 'package:flutter/material.dart';

class YoloFirstPage extends StatelessWidget {
  const YoloFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 230,
              child: Text('사진 / 카메라로 인식한 식재료로 음식을 추천해드립니다!',style: Theme.of(context).textTheme.displayLarge,)
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      SizedBox(height: 5,),
                      Text('카메라'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      SizedBox(height: 5,),
                      Text('갤러리'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ));
  }
}
