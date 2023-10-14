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
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Text('이번 요리를 몇 명이 드실 예정인가요?',style: Theme.of(context).textTheme.displayLarge,),
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
                    userCommandInputs['식사인원'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 2명 / 혼자',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('어느 정도의 요리 난이도를 선호하시나요?',style: Theme.of(context).textTheme.displayLarge,),
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
                    userCommandInputs['요리 난이도'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 초급 / 중급 / 고급',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('알려진 음식 알레르기가 있으신가요?',style: Theme.of(context).textTheme.displayLarge,),
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
                    userCommandInputs['알레르기 정보'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 생선 / 땅콩',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('어떤 종류의 음식을 원하시나요? ',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['음식 타입'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 한식, 중식',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('추가 요청 사항을 적어주세요!',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['추가요청사항'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 상황 / 디테일한 정보',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
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

