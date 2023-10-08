import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:recipt/View/Home/Category.dart';
import 'package:recipt/View/Upload/UploadCoverAndDes.dart';
import 'package:recipt/constans/colors.dart';

import '../../Server/account/MyPageServer.dart';

class MyPage extends StatelessWidget {
  const MyPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Column(
              children: [
                FutureBuilder<MypageUser>(
                  future: fetchUser(),
                  builder: (BuildContext context, AsyncSnapshot<MypageUser> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터를 기다리는 동안 로딩 인디케이터 표시
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // 오류가 발생한 경우
                      return Text("오류: ${snapshot.error}");
                    } else if (!snapshot.hasData) {
                      // 데이터가 없는 경우
                      return Text("데이터가 없습니다.");
                    } else {
                      MypageUser user = snapshot.data!;
                      // 받아온 사용자 데이터를 사용하여 위젯 구성
                      return Container(
                        width: 800,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: Colors.black87,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 40),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blueGrey,
                                backgroundImage: MemoryImage(user.profileData), // 서버 이미지 사용
                              ),
                            ),
                            SizedBox(width: 50,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(user.username, style: TextStyle(color: Colors.white, fontSize: 30),), // 사용자 이름 사용
                                SizedBox(height: 8,),
                                TextButton(
                                  onPressed: (){
                                    Get.to(UploadTab());
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(width: 1, color: Colors.greenAccent),
                                      ),
                                    ),
                                  ),
                                  child: Text('레시피 등록', style: TextStyle(color: Colors.greenAccent),),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 8,),
                Notice(),
              ],
            )
        )
    );
  }
}
class Notice extends StatelessWidget {

  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
        DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
              Container(
                child: TabBar(
                  labelColor: Colors.pink,
                  unselectedLabelColor: Colors.black,
                  tabs: [
                    Tab(text: '레시피'),
                    Tab(text: '요리 후기'),
                    Tab(text: '좋아요'),
                  ],
                ),
              ),
              Container(
                  height: 400, //height of TabBarView
                  decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                  ),
                  child: TabBarView(children: <Widget>[
                    Container(
                      child: MyRecipes(),
                    ),
                    Container(
                      child: FoodReview(),
                    ),
                    Container(
                      child: MyFavorite(),
                    ),
                  ])
              )
            ])
        ),
      ]),
    );
  }
}
class MyRecipes extends StatelessWidget {
  const MyRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(border: Border(
                bottom: BorderSide(
                  color: Colors.grey, width: 1,
                )
            )),
            margin: EdgeInsets.only(bottom: 10),
            child: TextButton(
              child: Row(
                children: [
                  Image.asset('assets/ramyun.jpg',width: 100,height: 100,),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('라면을 먹어보아요',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                      Text('면',style: TextStyle(color: Colors.black45)),
                      Text('라면을 맛잇게 먹는 방법',style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                Get.to(CategoryClick());
              },
            )
        );
      },
    );
  }
}
class FoodReview extends StatelessWidget {
  const FoodReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(border: Border(
                bottom: BorderSide(
                  color: Colors.grey, width: 1,
                )
            )),
            margin: EdgeInsets.only(bottom: 10),
            child: TextButton(
              child: Row(
                children: [
                  Image.asset('assets/ramyun.jpg',width: 100,height: 100,),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('라면을 먹어보아요',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                      Text('맛잇게 먹었습니다~',style: TextStyle(color: Colors.black45)),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          SizedBox(width: 5,),
                          Text('손지석',style: TextStyle(color: Colors.black),),
                          SizedBox(width: 12,),
                          for (var i=0; i< 5; i++)
                            Icon(Icons.star,color: Colors.orange,)
                        ],
                      ),

                    ],
                  ),
                ],
              ),
              onPressed: (){
                Get.to(CategoryClick());
              },
            )
        );
      },
    );
  }
}
class MyFavorite extends StatelessWidget {
  const MyFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(border: Border(
                bottom: BorderSide(
                  color: Colors.grey, width: 1,
                )
            )),
            margin: EdgeInsets.only(bottom: 10),
            child: TextButton(
              child: Row(
                children: [
                  Image.asset('assets/ramyun.jpg',width: 100,height: 100,),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('라면을 먹어보아요',style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                      Text('면',style: TextStyle(color: Colors.black45)),
                      Text('라면을 맛잇게 먹는 방법',style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                Get.to(CategoryClick());
              },
            )
        );
      },
    );
  }
}





