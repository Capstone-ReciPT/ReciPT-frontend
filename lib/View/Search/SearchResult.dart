import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/category/CategoryServer.dart';
import 'package:recipt/Server/search/SearchServer.dart';
import 'package:recipt/View/Search/GPTNoRecipe.dart';
import 'package:recipt/View/dbRecipe/Ingredient.dart';
import 'package:recipt/constans/colors.dart';

class SearchResult extends StatelessWidget {
  SearchResult({required this.userInput,Key? key}) : super(key: key);

  final userInput;
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
                          Text('검색 결과',style: Theme.of(context).textTheme.displayLarge,)
                        ]
                    ),
                  ),
                ),
                FutureBuilder<List<CategoryRecipe>>(
                    future: fetchSearch(userInput),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if(snapshot.data!.length > 0){
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
                                    Get.to(ProductItemScreen(id: snapshot.data![index].recipeId));
                                  },
                                )
                            );
                          },
                        );}
                        else {
                          return Column(
                            children: [
                              SizedBox(height: 40,),
                              Center(
                                child: Text("찾는 레시피가 없습니다.",style: Theme.of(context).textTheme.displayLarge,),
                              ),
                              SizedBox(height: 80,),
                              InkWell(
                                onTap: () {
                                  Get.to(gptNoRecipe(selectedFood: userInput));
                                },
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset('assets/icons/ChatGPT_logo.png',width: 50,height: 50,),
                                      SizedBox(width: 12,),
                                      Column(
                                        children: [
                                          Text('GPT에게 물어보세요!',style: Theme.of(context).textTheme.displayLarge),
                                        ],
                                      ),
                                      SizedBox(width: 20,)
                                    ],
                                  ),

                                ),
                              ),
                            ],
                          );
                        }
                      }
                      else if (snapshot.hasError) {
                        print(snapshot.error);
                        return Column(
                          children: [
                            Text('죄송합니다.. 서버 오류가 있습니다.'),
                          ],
                        );
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
