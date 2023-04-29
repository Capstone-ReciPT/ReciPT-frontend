import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/MainPage/Mypage.dart';
import 'MainPage/TodayRecipe.dart';
import 'RecipePage/Category.dart';

void main() {
  runApp(GetMaterialApp(
      theme : ThemeData(
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.black)
          ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
      ),
      home : MyApp())
  );
}

class Controller extends GetxController{
  var count= 0.obs;
  var currentDotIndex = 0.obs;
  var currentTab = 0.obs;
  var bannerIndex = 0.obs;
  changeDotIndex(index){
    currentDotIndex.value = index;
  }
  changeTab(index){
    currentTab.value = index;
  }
  changeBannerIndex(index){
    bannerIndex.value = index;
    print(bannerIndex.value);
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
        actions: [
          Container(
            width: 320,
            margin: EdgeInsets.only(top: 10,right: 5),
            child: TextField(
              decoration: InputDecoration(
                labelText: '요리, 재료 검색',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: IconButton(
                icon: Icon(Icons.keyboard_voice,color: Colors.black,size: 35),
                onPressed: () {
                  // TODO 검색 기능 구현
                  print('search button is clicked');
                }
            ),
          ),
        ],
      ),

      body: Obx(() => [HomePage(),SelectCategory(),Text('3'),MyPage()][c.currentTab.value]),
      bottomNavigationBar: DefalutBNB()
    );
  }
}

class DefalutBNB extends StatelessWidget {
  DefalutBNB({Key? key}) : super(key: key);

  final Controller c = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
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
            icon: Icon(Icons.account_circle_outlined),
            label: '마이페이지'
        ),
      ],
    ));
  }
}





