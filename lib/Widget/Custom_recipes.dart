import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/MainPageServer.dart';
import 'package:recipt/constans/colors.dart';

class CustomBoardMenu extends StatelessWidget {
  CustomBoardMenu({required this.location,Key? key}) : super(key: key);

  final location;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
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
                            Text('레시피',style: Theme.of(context).textTheme.displayLarge,)
                          ]
                      ),
                    ),
                  ),
                  FutureBuilder<List<MainRecipe>>(
                      future: fetchMain(location),
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
                                            Text(snapshot.data![index].foodName.toString(),style: TextStyle(fontWeight: FontWeight.w800,color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: [
                                                Icon(Icons.star,color: Colors.orange,),
                                                SizedBox(width: 8,),
                                                Text(snapshot.data![index].ratingScore.toString(),style: TextStyle(color: Colors.black45)),
                                              ],
                                            ),
                                            Text('',style: TextStyle(color: Colors.black),),
                                          ],
                                        ),
                                      ],
                                    ),
                                    onPressed: (){
                                      // Get.to(ProductItemScreen());
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
            )
        )));
  }
}