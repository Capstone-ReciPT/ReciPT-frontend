import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/CategoryServer.dart';
import 'package:recipt/Server/SearchServer.dart';
import 'package:recipt/constans/colors.dart';

class AfterSearch extends StatelessWidget {
  AfterSearch({this.userInput,Key? key}) : super(key: key);

  final userInput;
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
                        Text('검색 결과',style: Theme.of(context).textTheme.displayLarge,)
                      ]
                  ),
                ),
              ),
              FutureBuilder<List<CategoryRecipe>>(
                  future: fetchSearch(userInput),
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
                                },
                              )
                          );
                        },
                      );
                    }
                    else if (snapshot.hasError) {
                      return Center(
                        child: Text("레시피가 없습니다rk.",style: Theme.of(context).textTheme.displayLarge,),
                      );
                    }
                    return CircularProgressIndicator();
                  }
              ),
            ],
          ),
        )));
  }
}
