import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/View/api/chat/ChatScreen.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';

class TodayWhat extends StatefulWidget {
  TodayWhat({Key? key}) : super(key: key);

  var tempInput;
  @override
  State<TodayWhat> createState() => _TodayWhatState();
}

class _TodayWhatState extends State<TodayWhat> {
  final key = GlobalKey<FormState>();
  var userCommandInputs = {
    '몇명이서' : '',
    '어디서' : '',
    '음식종류' : '',
    '그밖의 요청사항' : '',
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
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
                        SizedBox(width: 60,),
                        Text('GPT 추천 음식',style: Theme.of(context).textTheme.displayLarge,)
                      ]
                  ),
                ),
              ),
              Text('몇 명이서 먹으실 생각인가요?',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 15,),
              CustomTextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "유효한 값을 입력해주세요!";
                  } else {
                    return null;
                  }
                },
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['몇명이서'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 2명 / 혼자',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('어느 곳에서 먹으실 생각인가요?',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 15,),
              CustomTextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "유효한 값을 입력해주세요!";
                  } else {
                    return null;
                  }
                },
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['어디서'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 집 / 거리',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('어떤 음식 종류를 원하시나요?',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "유효한 값을 입력해주세요!";
                  } else {
                    return null;
                  }
                },
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['음식종류'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 한식 / 중식 / 일식',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('그밖의 요청 사항들을 적어주세요!',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['그밖의 요청사항'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 아이와 같이 먹을 음식',
                prefixIcon: Icons.edit_note_sharp,
              ),
              CustomButton(onTap: (){
                setState(() {
                  if (key.currentState!.validate()){
                    String mapAsString = userCommandInputs.entries.map((entry) {
                      return '${entry.key}: ${entry.value}';
                    }).join(', \n');
                    Get.to(ChatScreen(firstMessage: mapAsString,));
                  }
                });
              }, text: '제출하기'),
            ],
          ),
        )
      )
    ));
  }
}

