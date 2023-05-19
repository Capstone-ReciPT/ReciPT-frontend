
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipt/Server/LoginServer.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

class SignUpAge extends StatefulWidget {
  SignUpAge({this.id,this.pw,Key? key}) : super(key: key);

  final id;
  final pw;


  @override
  State<SignUpAge> createState() => _SignUpAgeState();
}

class _SignUpAgeState extends State<SignUpAge> {
  // The variable related to showing or hidingf the text
  bool obscure = false;
  final ImagePicker _picker = ImagePicker();
  var _defaultImage = 'assets/icons/goodgood.png';
  File? _selectedImageFile;
  var _age;
  var _name;
  //The variable key related to the txt fild
  final key = GlobalKey<FormState>();

  //The validator key related to the text field
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
                            '프로필 설정',
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.black87,fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 40,),
                      Center(
                        child: Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: _selectedImageFile == null
                                  ? AssetImage(_defaultImage) as ImageProvider<Object>?
                                  : FileImage(_selectedImageFile!) as ImageProvider<Object>?,
                            ),
                            Positioned(
                              bottom: 20,
                              right: 20,
                              child: InkWell(
                                onTap: () async {
                                  final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);
                                  await _picker.pickImage(source: ImageSource.gallery);
                                  if (photo != null) {
                                    setState(() {
                                      _selectedImageFile = File(photo.path);
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                          SizedBox(height: 40,),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "이름을 입력해주세요";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value){
                              setState(() {
                                _name  = value;
                              });
                            },
                            hint: "이름",
                            prefixIcon: Icons.account_circle_outlined,
                          ),
                          CustomTextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "나이를 입력해주세요";
                              } else if (!RegExp(r'\d').hasMatch(value)){
                                return "올바른 나이 값을 입력해주세요.";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value){
                              setState(() {
                                _age  = value;
                              });
                            },
                            hint: "나이",
                            prefixIcon: Icons.numbers_outlined,
                          ),

                          // Part about password terms
                        ],
                      ),
                    ),
                    CustomButton(
                      onTap: () async{
                        if (key.currentState!.validate()){
                          await signUpFunc(widget.id,widget.pw,_selectedImageFile,_age,_name);
                          Get.to(MyApp());
                        }
                      },
                      text: "회원 가입",color: Colors.black,)
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}




