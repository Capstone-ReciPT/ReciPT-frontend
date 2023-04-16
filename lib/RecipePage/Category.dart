import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/main.dart';

var categoryName = [
  '찜/조림', '국/탕/찌개', '볶음/구이', '전/튀김', '면/만두', '밥/죽/떡', '무침', '김치/젓갈/장', '양념/소스/잼'
];

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 4/4,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return ElevatedButton(
                onPressed: (){},
                child: Text(categoryName[index],style: TextStyle(fontSize: 16),),
            );
          },
          itemCount: categoryName.length,
      ),
    );
  }
}