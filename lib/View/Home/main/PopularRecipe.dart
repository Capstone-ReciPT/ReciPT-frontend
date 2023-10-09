import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Server/MainPageServer.dart';
import 'package:recipt/View/dbRecipe/Ingredient.dart';
import 'package:recipt/Widget/Custom_recipes.dart';
import 'package:recipt/Widget/Like_button.dart';
import 'package:recipt/constans/colors.dart';

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