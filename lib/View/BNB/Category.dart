import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/CategoryServer.dart';
import 'package:recipt/View/Other/Ingredient.dart';
import 'package:recipt/View/Other/RecipePage.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

var category = [
  {'name' : '채소','path' : 'assets/icons/category/yachae_color.png'},
  {'name' : '고기','path' : 'assets/icons/category/gogi_color.png'},
  {'name' : '해산물','path' : 'assets/icons/category/fish_color.png'},
  {'name' : '샐러드','path' : 'assets/icons/category/salad_color.png'},
  {'name' : '수프','path' : 'assets/icons/category/soup_color.png'},
  {'name' : '밥','path' : 'assets/icons/category/rice_color.png'},
  {'name' : '면','path' : 'assets/icons/category/myun_color.png'},
  {'name' : '국','path' : 'assets/icons/category/dosirock_color.png'},
  {'name' : '기타','path' : 'assets/icons/category/more.png'},
];

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ButtonToSearchTab(),
          SizedBox(height: 10,),
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
      margin: EdgeInsets.only(left: 10,right: 10),
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
                Get.to(BoardPage(category[index]['name']));
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

class BoardPage extends StatelessWidget {
  BoardPage(this.selectedCategory, {Key? key}) : super(key: key);

  final selectedCategory;
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
                    Text('카테고리',style: Theme.of(context).textTheme.displayLarge,)
                  ]
                ),
              ),
            ),
            FutureBuilder<List<CategoryRecipe>>(
                future: fetchCategory(selectedCategory),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
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
                                  Image.network(snapshot.data![index].thumbnailImage, width: 100, height: 100),
                                  SizedBox(width: 12,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(snapshot.data![index].foodName.toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                                      Text(snapshot.data![index].category.toString(),style: TextStyle(color: Colors.black45)),
                                      Text('',style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ],
                              ),
                              onPressed: (){
                                Get.to(ProductItemScreen());
                              },
                            )
                        );
                      },
                    );
                  }
                  else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
            ),
          ],
        ),
    )));
  }
}

class Top10ForYear extends StatelessWidget {
  const Top10ForYear({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryRecipe>>(
        future: fetchCategory('채소'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
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
                          Image.network(snapshot.data![index].thumbnailImage, width: 100, height: 100),
                          SizedBox(width: 12,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index].foodName.toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                              Text(snapshot.data![index].category.toString(),style: TextStyle(color: Colors.black45)),
                              Text('',style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ],
                      ),
                      onPressed: (){
                        Get.to(ProductItemScreen());
                      },
                    )
                );
              },
            );
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
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
                    Text('라면을 맛잇게 먹어보아요',style: TextStyle(color: Colors.black),),
                  ],
                ),
              ],
            ),
            onPressed: (){
              Get.to(ProductItemScreen());
            },
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
