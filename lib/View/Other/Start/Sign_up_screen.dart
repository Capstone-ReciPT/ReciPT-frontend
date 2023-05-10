
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // The variable related to showing or hidingf the text
  bool obscure = false;

  //The variable key related to the txt fild
  final key = GlobalKey<FormState>();

  //The validator key related to the text field
  bool _contansANumber = false;
  bool _numberofDigits = false;
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
                                return "이메일을 입력해주세요.";
                              } else {
                                return null;
                              }
                            },
                            hint: "이메일 또는 전화번호",
                            prefixIcon: IconlyBroken.message,
                          ),
                          CustomTextFormField(
                            onChanged: (value) {
                              setState(() {
                                _numberofDigits = value.length < 6 ? false : true;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "비밀번호를 입력해주세요.";
                              } else {
                                return null;
                              }
                            },
                            obscureText: obscure,
                            hint: "비밀번호",
                            prefixIcon: IconlyBroken.lock,
                            suffixIcon: obscure == true
                                ? IconlyBroken.show
                                : IconlyBroken.hide,
                            onTapSuffixIcon: () {
                              setState(() {});
                              obscure = !obscure;
                            },
                          ),
                          // Part about password terms
                          passwordTerms(
                              contains: _contansANumber, ateast6: _numberofDigits),
                        ],
                      ),
                    ),
                    CustomButton(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => VerificationCode(),
                          //     ));
                          setState(() {
                            key.currentState!.validate();
                          });
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