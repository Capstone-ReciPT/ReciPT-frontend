import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/PageController.dart';
import 'package:recipt/Server/GPTRecipeServer.dart';
import 'package:recipt/Server/GPTsend.dart';
import 'package:recipt/View/BNB/Yolo/SelectedRecipePage.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

class GPTanswer extends StatefulWidget {
  GPTanswer({required this.GPTSuggestListString,Key? key}) : super(key: key);

  final GPTSuggestListString;
  var GPTSuggestList;
  @override
  State<GPTanswer> createState() => _GPTanswerState();

}

class _GPTanswerState extends State<GPTanswer> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.GPTSuggestListString);
    widget.GPTSuggestList = fetchGPTsuggest(widget.GPTSuggestListString);
  }

  Future<bool> onBackKeyGPTSuggest(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFFFFFF),
            title: Text(
              '냉장고 파먹기를 끝내시겠습니까?',
              style: TextStyle(color: mainText),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    //onWillpop에 true가 전달되어 앱이 종료 된다.
                    fetchGPTRefresh();
                    SystemNavigator.pop(); // 앱 종료
                  },
                  child: Text('끝내기',style: TextStyle(color: SecondaryText),)),
              TextButton(
                  onPressed: () {
                    //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                    Navigator.of(context).pop(false); // 대화 상자 닫기
                  },
                  child: Text('아니요',style: TextStyle(color: SecondaryText),)),
            ],
          );
        }) ?? false; // 취소 버튼이 눌릴 경우 false 반환
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => onBackKeyGPTSuggest(context),
      child: SafeArea(child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Text('GPT의 추천 레시피',style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 34),),
              SizedBox(height: 70,),
              FutureBuilder<List<String>>(
                  future: widget.GPTSuggestList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return CustomButton(
                            onTap: (){
                              Get.to(SelectedRecipe(selectedFood: snapshot.data?[index]));
                            },
                            text: snapshot.data?[index],
                            textColor: mainText,
                            color: Colors.black12,
                          );
                          // return gptSelectContainer(context,snapshot.data?[index]);
                        },
                      );
                    }
                    else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
              ),
            ],
          ),
        ),
      )),
    );
  }

  gptSelectContainer(context,snapshotText){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap:(){

          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.15,
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1),
            ),
            child: Center(
              child: Text(snapshotText,style: Theme.of(context).textTheme.displayLarge,),
            ),
          ),
        )
      ],
    );
  }
}

