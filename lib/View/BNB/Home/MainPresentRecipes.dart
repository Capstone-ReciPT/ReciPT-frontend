import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/MainPageServer.dart';
import 'package:recipt/View/BNB/Category.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Widget/Custom_recipes.dart';
import 'package:recipt/Widget/Like_button.dart';
import 'package:recipt/constans/colors.dart';

import '../../Other/Ingredient.dart';

class PopularRecipe extends StatelessWidget {
  PopularRecipe({Key? key}) : super(key: key);

  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text('인기 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: mainText),),
            TextButton(
                onPressed: (){
                  Get.to(CustomBoardMenu(location: 'like',));
                },
                child: Text('See all',style: TextStyle(color: Colors.orange),)),
          ],
        ),
        FutureBuilder<List<MainRecipe>>(
          future: fetchMain('like'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 310,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    controller.changeDotIndex(index);
                  },
                ),
                items: snapshot.data!.map((data) {
                  return Builder(builder: (BuildContext context){
                    return Container(
                      margin: EdgeInsets.only(top: 15,bottom: 5),
                      width: 400,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Get.to(ProductItemScreen(id: data.recipeId,));
                              return;
                            },
                            child: Stack(
                              children: [
                                Image.network(data.thumbnailImage ?? '',width:400,height: 220,fit: BoxFit.fill),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: LikeButtonWidget(),
                                )
                              ],
                            ),
                          ),
                          Container(margin: EdgeInsets.only(top: 10),child: Text(data.foodName ?? '3',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    );
                  });
                }).toList(),
              );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }

        ),
    ]);
  }
}

class TodayRecipeNotice extends StatelessWidget {
  const TodayRecipeNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text('오늘의 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: mainText),),
        TextButton(
            onPressed: (){
              Get.to(CustomBoardMenu(location: 'view',));
            },
            child: Text('See all',style: TextStyle(color: Colors.orange),)),
      ],
    );
  }
}

class TodayRecipe extends StatelessWidget {
  TodayRecipe({Key? key}) : super(key: key);

  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: 300,
      child: FutureBuilder<List<MainRecipe>>(
          future: fetchMain('view'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length, itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.only(right: 50),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Get.to(ProductItemScreen(id: snapshot.data![index].recipeId)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Stack(
                              children: [
                                Image.network(snapshot.data![index].thumbnailImage,fit: BoxFit.fill,height: 200,),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: LikeButtonWidget(),
                                )
                              ],
                            )
                        ),

                      ),

                      Container(margin: EdgeInsets.only(top: 10),child: Text(snapshot.data![index].foodName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                );
              });
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }

      ),
    );
  }
}

class NewRecipeNotice extends StatelessWidget {
  const NewRecipeNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textBaseline: TextBaseline.ideographic,
      children: [
        Text('새로운 레시피',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w800,color: mainText),),
        TextButton(
            onPressed: (){
              Get.to(CustomBoardMenu(location: 'recent',));
            },
            child: Text('See all',style: TextStyle(color: Colors.orange),)),
      ],
    );
  }
}

class NewRecipe extends StatelessWidget {
  NewRecipe({Key? key}) : super(key: key);

  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      height: 325,
      child: FutureBuilder<List<MainRecipe>>(
          future: fetchMain('recent'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.length, itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: EdgeInsets.only(right: 50),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => Get.to(ProductItemScreen(id: snapshot.data![index].recipeId)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Stack(
                              children: [
                                Image.network(snapshot.data![index].thumbnailImage,fit: BoxFit.fill,height: 200,),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: LikeButtonWidget(),
                                )
                              ],
                            )
                        ),

                      ),
                      Container(margin: EdgeInsets.only(top: 10),child: Text(snapshot.data![index].foodName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                );
              });
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }
      ),
    );
  }
}



