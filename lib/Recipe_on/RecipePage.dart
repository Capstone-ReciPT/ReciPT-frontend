import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';
import 'package:recipt/RecipePage/Category.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('비빔밥 만들기',style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
        body: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('고추장 1숟가락')
                  ],
                )
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.to(CookingMenu());
          },
          child: Icon(Icons.navigate_next),
        ),
    );
  }
}

class CookingMenu extends StatelessWidget {
  const CookingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text('Step 1/10',style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black)),
        actions: [
          IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.close),color: Colors.black,)
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/bibim.jpg'),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey
              ),
              margin: EdgeInsets.only(top: 30),
              width: 400,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.',style: TextStyle(fontSize: 20)),
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(CookingMenu());
        },
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
