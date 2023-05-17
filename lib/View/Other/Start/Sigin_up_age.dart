
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

class SignUpAge extends StatefulWidget {
  const SignUpAge({Key? key}) : super(key: key);

  @override
  State<SignUpAge> createState() => _SignUpAgenState();
}

class _SignUpAgenState extends State<SignUpAge> {
  // The variable related to showing or hidingf the text
  bool obscure = false;

  //The variable key related to the txt fild
  final key = GlobalKey<FormState>();

  //The validator key related to the text field
  var _selectedValue = '20';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            reverse: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      key: key,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "환영합니다",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black87,fontWeight: FontWeight.w800),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              "",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "나이를 입력해주세요";
                              } else if (!value.isNum){
                                return "올바른 나이 값을 입력해주세요.";
                              } else {
                                return null;
                              }
                            },
                            hint: "나이",
                            prefixIcon: Icons.numbers_outlined,
                          ),
                          // Part about password terms
                        ],
                      ),
                    ),
                    CustomButton(
                      onTap: () {
                        Get.to(MyApp());
                      },
                      text: "회원 가입",color: Colors.black,)
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  // Part about password terms
  passwordTerms({
    required bool contains,
    required bool ateast6,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "비밀번호는 다음을 만족해야 합니다. :",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: mainText),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: ateast6 == false ? outline : Color(0xFFE3FFF1),
              child: Icon(
                Icons.done,
                size: 12,
                color: ateast6 == false ? SecondaryText : primary,
              ),
            ),
            Text(
              "  최소 6문자 이상",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ateast6 == false ? SecondaryText : mainText),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: contains == false ? outline : Color(0xFFE3FFF1),
              child: Icon(
                Icons.done,
                size: 12,
                color: contains == false ? SecondaryText : primary,
              ),
            ),
            Text(
              "  숫자를 포함해야 함",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: contains == false ? SecondaryText : mainText),
            )
          ],
        ),
      ],
    );
  }
}