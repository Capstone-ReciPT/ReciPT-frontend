import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';

var category = [
  {'name' : '야채','path' : 'assets/icons/category/yachae_color.png'},
  {'name' : '고기','path' : 'assets/icons/category/gogi_color.png'},
  {'name' : '해산물','path' : 'assets/icons/category/fish_color.png'},
  {'name' : '샐러드','path' : 'assets/icons/category/salad_color.png'},
  {'name' : '수프','path' : 'assets/icons/category/soup_color.png'},
  {'name' : '밥','path' : 'assets/icons/category/rice_color.png'},
  {'name' : '면','path' : 'assets/icons/category/myun_color.png'},
  {'name' : '도시락','path' : 'assets/icons/category/dosirock_color.png'},
  {'name' : '기타','path' : 'assets/icons/category/more.png'},
];

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MajorCategory(),
          Divider( // 이 줄을 추가하세요.
            color: Colors.grey,
            thickness: 1,
            height: 20, // 간격 조절을 원하시면 height 값을 변경하세요.
          ),
          SizedBox(height: 8,),
          Text('최근에 사람들이',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)),
          Text('이런 조리법으로 요리했어요',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
          BoardMenu(),
        ],
      ),
    );
  }
}

class MajorCategory extends StatelessWidget {
  const MajorCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30,left: 10,right: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3/1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return TextButton(
              onPressed: (){
                Get.to(CategoryClick());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(category[index]['path'] ?? '',width: 35,height: 35),
                  SizedBox(width: 10,),
                  Text(category[index]['name'] ?? '',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.black),)
                ],
              )
          );
        },
        itemCount: category.length,
      ),
    );
  }
}

class BoardMenu extends StatelessWidget {
  const BoardMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
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
                    Text('라면을 맛잇게 먹어보아요 하 배고파 시발',style: TextStyle(color: Colors.black),),
                  ],
                ),
              ],
            ),
            onPressed: (){},
          )
        );
      },
    );
  }
}

class CategoryClick extends StatelessWidget {
  const CategoryClick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BoardMenu(),
      bottomNavigationBar: DefalutBNB(),
    );
  }
}
