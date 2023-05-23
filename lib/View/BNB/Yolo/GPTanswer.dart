import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/GPTsend.dart';
import 'package:recipt/View/BNB/Yolo/SelectedRecipePage.dart';

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
    widget.GPTSuggestList = fetchGPTsuggest(widget.GPTSuggestListString);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
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
                          return gptSelectContainer(context,snapshot.data?[index]);
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
        )
    ));
  }

  gptSelectContainer(context,snapshotText){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap:(){
            Get.to(SelectedRecipe());
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

