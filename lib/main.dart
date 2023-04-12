import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'MainPage/TodayRecipe.dart';
import 'RecipePage/Category.dart';

void main() {
  runApp(GetMaterialApp(
      theme : ThemeData(
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData()
      ),
      home : MyApp())
  );
}

class Controller extends GetxController{
  var count= 0.obs;
  var currentDotIndex = 0.obs;
  var currentTab = 0.obs;
  changeDotIndex(index){
    currentDotIndex.value = index;
  }
  changeTab(index){
    currentTab.value = index;
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

      body: Obx(() => [HomePage(),SelectCategory(),Text('3'),Text('4')][c.currentTab.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        currentIndex: c.currentTab.value,
        onTap: (index) => c.changeTab(index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_rounded),
              label: '레시피'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_rounded),
              label: '음식 추천'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: '설정'
          ),
        ],
      ),
    ));
    // 8줄의 Navigator.push를 간단한 Get.to()로 변경합니다. context는 필요없습니다.
    // body: Center(child: ElevatedButton(
    //     child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
    // floatingActionButton:
    // FloatingActionButton(child: Icon(Icons.add), onPressed: c.increment));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text('오늘의 레시피',style: TextStyle(fontWeight: FontWeight.w800,
              color: Colors.black, fontSize: 30),),
          // 오늘의 레시피
          Container( margin: EdgeInsets.only(top: 20), child: SlidePage()),

        ],
      ),
    );
  }
}


