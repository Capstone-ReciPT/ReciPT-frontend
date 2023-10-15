import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/gpt/GptLoadRecipeServer.dart';
import 'package:recipt/View/Upload/GptUploadCover.dart';
import 'package:recipt/constans/colors.dart';

class LoadGptRecipe extends StatefulWidget {
  const LoadGptRecipe({Key? key}) : super(key: key);

  @override
  State<LoadGptRecipe> createState() => _LoadGptRecipeState();
}

class _LoadGptRecipeState extends State<LoadGptRecipe> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          Text('가져오기',style: Theme.of(context).textTheme.displayLarge,)
                        ]
                    ),
                  ),
                ),
                FutureBuilder<ShowGptRecipe?>(
                  future: fetchLoadGptRecipeCover(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: Container(
                            width: 150,
                            height: 80,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("assets/icons/voice2.gif"),
                              radius: 40.0,
                            )
                      ));
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final foodData = snapshot.data!;
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: foodData.count,
                        itemBuilder: (context, index) {
                          final foodItem = foodData.data[index];
                          return InkWell(
                            onTap: () {
                              // 탭할 때 실행할 코드. 예: 다른 화면으로 이동하기, 다이얼로그 표시하기 등
                              print('${foodItem.foodName} tapped!');
                              Get.to(GptUploadCover(
                                togptId: foodItem.gptId,
                                tofoodName: foodItem.foodName,
                              ));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(foodItem.foodName.substring(0, 1)), // 첫 글자만 가져오기
                              ),
                              title: Text(foodItem.foodName),
                              subtitle: Text(foodItem.createdDate),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


