import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/View/BNB/MainPresentRecipes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipt/View/Other/SearchPage.dart';
import 'package:recipt/View/Other/UploadCoverAndDes.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400,
        margin: EdgeInsets.only(left: 10,right: 10),
        child: Column(
            children: [
              ButtonToSearchTab(),
              SizedBox(height: 10,),
              // Container( margin: EdgeInsets.only(top: 10,bottom: 20), child: HomeBanner()),
              MainButtons(),
              SizedBox(height: 20,),
              PopularRecipe(),
              TodayRecipeNotice(),
              TodayRecipe(),
              NewRecipeNotice(),
              NewRecipe(),
            ]
        ),
      ),
    );
  }
}

class HomeBanner extends StatelessWidget {
  HomeBanner({Key? key}) : super(key: key);

  final controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 100,
        autoPlay: false,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          controller.changeBannerIndex(index);
        },
      ),
      items: foodList.map((data) {
        return Builder(builder: (BuildContext context){
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/Banner/banner.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  bottom: 15,
                  right: 15,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                        color: Colors.black54,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Obx(() => Text(
                          "${controller.bannerIndex.value+1} / 3",
                          style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w800),
                        ),)
                    ),
                  )
              )
            ],
          );
        }
        );
      }).toList(),
    );
  }
}

class MainButtons extends StatelessWidget {
  const MainButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(
            onPressed: (){
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/refrigerator.svg',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8,),
                Text('냉장고\n파먹기',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
              ],
            )
        ),
        TextButton(onPressed: (){}, child: Column(
          children: [
            SvgPicture.asset(
              'assets/icons/today.svg',
              width: 60,
              height: 50,
            ),
            SizedBox(height: 8,),
            Text('오늘\n뭐먹지',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
          ],
        )),TextButton(
            onPressed: (){
              Get.to(UploadTab());
            },
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/writing.svg',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8,),
                Text('레시피\n쓰기',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            )
        ),
        TextButton(
            onPressed: (){},
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/review.svg',
                  width: 50,
                  height: 50,
                ),
                SizedBox(height: 8,),
                Text('리뷰\n작성',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
              ],
            )
        ),
      ],
    );
  }
}