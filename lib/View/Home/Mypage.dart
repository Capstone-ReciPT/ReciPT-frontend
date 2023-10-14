import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/View/Home/Category.dart';
import 'package:recipt/View/Upload/UploadCoverAndDes.dart';
import 'package:recipt/View/dbRecipe/Ingredient.dart';

import '../../Server/account/MyPageServer.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile>(
      future: fetchUser(),
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
                width: 150,
                height: 80,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/icons/voice2.gif"),
                  radius: 40.0,
                )
            ),
          );
        } else if (snapshot.hasError) {
          // 오류가 발생한 경우
          return Text("오류: ${snapshot.error}");
        } else if (!snapshot.hasData) {
          // 데이터가 없는 경우
          return Text("데이터가 없습니다.");
        } else {
          UserData user = snapshot.data!.data;
          // 받아온 사용자 데이터를 사용하여 위젯 구성
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
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
                              backgroundImage: MemoryImage(snapshot.data!.profile), // 서버 이미지 사용
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
                    ),
                    SizedBox(height: 8,),
                    Notice(user),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Notice(UserData user){
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
      DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Container(
              child: TabBar(
                labelColor: Colors.pink,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: '레시피'),
                  Tab(text: '좋아요'),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height, //height of TabBarView
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                ),
                child: TabBarView(children: <Widget>[
                  Container(
                    child: MyRecipe(user),
                  ),
                  Container(
                    child: MyFavorite(user),
                  ),
                ])
            )
          ])
      ),
    ]);


  }
  MyRecipe(UserData user){
    if (user.userRegisterDtos.isEmpty){
      return Column(
        children: [
          SizedBox(height: 80,),
          Text('등록한 게시물이 없습니다!',style: context.textTheme.displayLarge,),
        ],
      );
    }
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: user.userRegisterDtos.length,
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
                  Image(
                    image: MemoryImage(user.userRegisterDtos[index].thumbnailImageByte),
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.userRegisterDtos[index].foodName,style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                      Text(user.userRegisterDtos[index].category,style: TextStyle(color: Colors.black45)),
                      Text(user.userRegisterDtos[index].comment,style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                Get.to(ProductItemScreen(id: user.userRegisterDtos[index].registerRecipeId,));
              },
            )
        );
      },
    );
  }
  MyFavorite(UserData user){
    if (user.recipeHeartDtos.isEmpty && user.registerHeartDtos.isEmpty){
      return Column(
        children: [
          SizedBox(height: 80,),
          Text('좋아요한 게시물이 없습니다!',style: context.textTheme.displayLarge,)
        ],
      );
    }
    List<dynamic> combinedList = [];
    for (var dto in user.recipeHeartDtos) {
      combinedList.add({
        "id": dto.recipeId,
        "foodName": dto.foodName,
        "category": dto.category,
        "thumbnailImage": dto.thumbnailImage,
        "registerCheck" : false
        // "thumbnailImageByte": convertImageUrlToByte(dto["thumbnailImage"]),
        // 원래 이미지 변환 로직이 필요하면 주석을 해제하시고 해당 함수를 사용하세요.
      });
    }

    for (var dto in user.registerHeartDtos) {
      combinedList.add({
        "id": dto.registerId,
        "foodName": dto.foodName,
        "category": dto.category,
        "thumbnailImage": dto.thumbnailImageByte,
        "registerCheck" : true
      });
    }
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: combinedList.length,
      itemBuilder: (context, index) {
        var currentItem = combinedList[index];  // 현재 아이템에 대한 참조를 가져옵니다.
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
                  currentItem['registerCheck']
                  ?
                  Image(
                    image: MemoryImage(currentItem['thumbnailImage']),
                    width: 100,
                    height: 100,
                  )
                  : Image.network(
                      currentItem['thumbnailImage'],
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 12,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(currentItem["foodName"],style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                      Text(currentItem["category"],style: TextStyle(color: Colors.black45)),
                    //   Text(user.data.recipeHeartDtos[index].comment,style: TextStyle(color: Colors.black45)),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                Get.to(ProductItemScreen(id: user.recipeHeartDtos[index].recipeId,));
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






