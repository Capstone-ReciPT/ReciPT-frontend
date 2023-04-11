import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MainPage/TodayRecipe.dart';

void main() {
  runApp(GetMaterialApp(
      theme : ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
      ),
      home : MyApp())
  );
}

class Controller extends GetxController{
  var count= 0.obs;
  RxInt currentIndex = 0.obs;

  changeIndex(index){
    currentIndex.value = index;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              Image.asset('assets/cover.jpg',width: 50,height: 50),
            ],
          ),
        ),
        actions: [
          Container(
            width: 200,
            margin: EdgeInsets.only(top: 10,right: 15),
            child: TextField(
              decoration: InputDecoration(
                labelText: '검색',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          IconButton(
              icon: Icon(Icons.search,color: Colors.black),
              onPressed: () {
                // TODO 검색 기능 구현
                print('search button is clicked');
              }
          ),
        ],
      ),

      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Text('오늘의 레시피',style: TextStyle(fontWeight: FontWeight.w800,
                color: Colors.black, fontSize: 30),),
            // 오늘의 레시피
            Container( margin: EdgeInsets.only(top: 20), child: SlidePage()),

          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //
      //   items: [
      //     TextButton(
      //       child: Icon(Icons.home_outlined),
      //       onPressed: (){},
      //     ),
      //   ],
      // ),
    );
    // 8줄의 Navigator.push를 간단한 Get.to()로 변경합니다. context는 필요없습니다.
    // body: Center(child: ElevatedButton(
    //     child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
    // floatingActionButton:
    // FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
  }
}


class TextBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: TextField(
        decoration:
        InputDecoration(border: InputBorder.none, hintText: 'Search'),
      ),
    );
  }
}
