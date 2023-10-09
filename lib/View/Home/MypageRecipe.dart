import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/account/MyPageRegisterRecipeServer.dart';
import 'package:recipt/View/Home/Category.dart';

class MyRecipe extends StatelessWidget {
  const MyRecipe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserData>(
      future: fetchUserRegisterRecipe(),
      builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 기다리는 동안 로딩 인디케이터 표시
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 18,),
                Text("실행중입니다",style: context.textTheme.displayMedium,),
                Text("잠시만 기다려주세요!",style: context.textTheme.displayMedium,),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          // 오류가 발생한 경우
          return Center(
              child: Text("오류: ${snapshot.error}")
          );
        } else if (!snapshot.hasData) {
          // 데이터가 없는 경우
          return Center(
              child: Text("데이터가 없습니다.")
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.userRegisterDtos.length,
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
                        Image(
                          image: MemoryImage(snapshot.data!.userRegisterDtos[index].thumbnailImage),
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(width: 12,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(snapshot.data!.userRegisterDtos[index].foodName,style: TextStyle(fontWeight: FontWeight.w800,color: Colors.green),),
                            Text(snapshot.data!.userRegisterDtos[index].category,style: TextStyle(color: Colors.black45)),
                            Text(snapshot.data!.userRegisterDtos[index].comment,style: TextStyle(color: Colors.black45)),
                          ],
                        ),
                      ],
                    ),
                    onPressed: (){
                      Get.to(CategoryClick());
                    },
                  )
              );
            },
          );
        }
      },
    );
  }
}