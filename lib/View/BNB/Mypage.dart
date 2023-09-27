import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:recipt/View/BNB/Category.dart';
import 'package:recipt/View/Other/Upload/UploadCoverAndDes.dart';
import 'package:recipt/constans/colors.dart';

class MyPage extends StatelessWidget {
  const MyPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Column(
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
                          child: Icon(Icons.person,color: Colors.white,size: 80,),
                        ),
                      ),
                      SizedBox(width: 50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('손지석',style: TextStyle(color: Colors.white,fontSize: 30),),
                          SizedBox(height: 8,),
                          TextButton(
                              onPressed: (){
                                Get.to(UploadTab());
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(width: 1,color: Colors.greenAccent),
                                  ),
                                ),
                              ),
                              child: Text('레시피 등록',style: TextStyle(color: Colors.greenAccent),)
                          )
                        ],
                      )
                    ],
                  ),
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
class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: mainText,
                            )
                        ),
                        SizedBox(width: 90,),
                        Text('설정',style: Theme.of(context).textTheme.displayLarge,)
                      ]
                  ),
                ),
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: 5,
              //   itemBuilder: (context, index) {
              //     return Container(
              //         decoration: BoxDecoration(border: Border(
              //             bottom: BorderSide(
              //               color: Colors.grey, width: 1,
              //             )
              //         )),
              //         margin: EdgeInsets.only(bottom: 10),
              //         child: TextButton(
              //           child: Row(
              //             children: [
              //               SizedBox(width: 20,),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text('1',style: Theme.of(context).textTheme.displayLarge,),
              //                 ],
              //               ),
              //             ],
              //           ),
              //           onPressed: (){
              //           },
              //         )
              //     );
              //   },
              // ),
            Container(
              decoration: BoxDecoration(border: Border(
                  bottom: BorderSide(
                    color: Colors.grey, width: 1,
                  )
              )),
              margin: EdgeInsets.only(bottom: 10),
              child: TextButton(
                child: Row(
                  children: [
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('로그아웃',style: Theme.of(context).textTheme.displayLarge,),
                      ],
                    ),
                  ],
                ),
                onPressed: (){
                  print(getJwt());
                },
              )
            ),
            ],
          ),
        )));
  }
}




