import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/TotalController.dart';
import 'package:recipt/View/BNB/Home/HomePage.dart';
import 'package:recipt/View/BNB/Mypage.dart';
import 'package:recipt/View/Other/Start/StartScreen.dart';
import 'package:recipt/constans/colors.dart';
import 'View/BNB/Yolo/RecipeRecommend.dart';
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

//휴대폰 피지컬 버튼 뒤로 가기 눌렀을때,
Future<bool> _onBackKey(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text(
            '끝내시겠습니까?',
            style: TextStyle(color: mainText),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  //onWillpop에 true가 전달되어 앱이 종료 된다.
                  Navigator.pop(context, true);
                },
                child: Text('끝내기',style: TextStyle(color: SecondaryText),)),
            TextButton(
                onPressed: () {
                  //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                  Navigator.pop(context, false);
                },
                child: Text('아니요',style: TextStyle(color: SecondaryText ),)),
          ],
        );
      });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final TotalController totalController = Get.put(TotalController());
    final Controller c = Get.find();
    return WillPopScope(
      onWillPop: () => _onBackKey(context),
      child: SafeArea(child: Scaffold(
          body: Obx(() => [HomePage(),SelectCategory(),YoloImage(),MyPage()][c.currentTab.value]),
          bottomNavigationBar: DefalutBNB()
      )),
    );
  }

}



class DefalutBNB extends StatelessWidget {
  DefalutBNB({Key? key}) : super(key: key);

  final Controller c = Get.find();
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
            label: '냉장고 파먹기'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '마이페이지'
        ),
      ],
    ));
  }
}





