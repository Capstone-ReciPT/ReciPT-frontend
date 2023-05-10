import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/View/BNB/HomePage.dart';
import 'package:recipt/View/BNB/Mypage.dart';
import 'package:recipt/View/Other/Start/StartScreen.dart';
import 'package:recipt/constans/colors.dart';
import 'View/BNB/RecipeRecommend.dart';
import 'View/BNB/Category.dart';
import 'package:recipt/Controller/PageController.dart';
void main() {
  runApp(GetMaterialApp(
      theme : ThemeData(
          textTheme: TextTheme(
            displayLarge: TextStyle(
              color: mainText,
              fontFamily: 'Inter',
              fontSize: 22,
              fontWeight: FontWeight.w700
            ),
            displayMedium: TextStyle(
                color: mainText,
                fontSize: 17,
                fontWeight: FontWeight.w700
            ),
            displaySmall: TextStyle(
                color: mainText,
                fontSize: 15,
                fontWeight: FontWeight.w700
            ),
            bodyLarge: TextStyle(
              color: SecondaryText,
                fontFamily: 'Inter',
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),
            bodyMedium: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                fontWeight: FontWeight.w700
            ),
            bodySmall: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w700
            ),
            titleMedium: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                fontWeight: FontWeight.w500
            ),
          ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(),
      ),
      home : StartScreen())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final Controller c = Get.put(Controller());
    return SafeArea(child: Scaffold(
        body: Obx(() => [HomePage(),SelectCategory(),YoloImage(),MyPage()][c.currentTab.value]),
        bottomNavigationBar: DefalutBNB()
    ));
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
            label: '카테고리'
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





