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
              Text('선호하는 요리 난이도를 말해주세요.',style: Theme.of(context).textTheme.displayLarge,),
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
              Text('특별히 사용하고 싶은 재료가 있나요?',style: Theme.of(context).textTheme.displayLarge,),
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
                    userCommandInputs['선호 재료'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 고기 / 야채',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('피하고 싶은 재료가 있나요?',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['비선호 재료'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 생선, 피망',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('알려진 음식 알레르기가 있으신가요?',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['알레르기 정보'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 땅콩 알레르기',
                prefixIcon: Icons.edit_note_sharp,
              ),
              SizedBox(height: 24,),
              Text('어떤 종류의 음식을 원하시나요?',style: Theme.of(context).textTheme.displayLarge,),
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
              Text('조리에 얼마나 많은 시간을 하실 건가요?',style: Theme.of(context).textTheme.displayLarge,),
              SizedBox(height: 20,),
              CustomTextFormField(
                onChanged:(value) {
                  setState(() {
                    userCommandInputs['조리 시간'] = value;
                  });
                },
                onEditingComplete: () {

                },
                hint: 'ex) 20분, 1시간',
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

