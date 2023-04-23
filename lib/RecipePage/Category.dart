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
    return Container(
      child: Column(
        children: [
          MajorCategory()
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
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3/1.5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return TextButton(onPressed: (){},
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
