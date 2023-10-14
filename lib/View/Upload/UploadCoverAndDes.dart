
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipt/View/Upload/LoadGptRecipe.dart';
import 'package:recipt/View/Upload/UploadRecipeAll.dart';
import 'package:recipt/Widget/Custom_button.dart';
import '../../../Widget/Custom_Text_Form_field.dart';
import '../../../constans/colors.dart';
import 'package:recipt/Widget/CustomTextFieldInUpload.dart';

class UploadTab extends StatefulWidget {
  UploadTab({Key? key}) : super(key: key);

  @override
  State<UploadTab> createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab> {
  bool obscure = true;
  final nextKey = GlobalKey<FormState>();
  XFile? imageFile;
  String? foodName;
  String? foodDescription;
  String? foodCategory ='채소';

  final _valueList = ['채소','고기','해산물','샐러드','국','밥','면','찌개','기타'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: SingleChildScrollView( child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: nextKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: (){
                          Get.back();
                        },
                        child: Text(
                          '취소',
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20,color: Secondary),
                        )
                    ),
                    TextButton(
                        onPressed: (){
                          Get.to(LoadGptRecipe());
                        },
                        child: Text(
                          'GPT 레시피 불러오기',
                          style: Theme.of(context).textTheme.displaySmall,
                        )
                    ),
                    Text(
                      "1/2",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: SecondaryText),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                        pickImage();
                      },
                      child: imageFile != null ? Container(
                          child: Image.file(File(imageFile!.path),width: double.infinity,height: 160,))
                          : DottedBorder(
                        dashPattern: [15,5],
                        color: outline,
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        child: SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Icon(
                                  Icons.photo,
                                  size: 65,
                                  color: Colors.grey,
                                ),
                                Text('커버 업로드',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                                Text('12MB 이하'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text('음식 이름',style: Theme.of(context).textTheme.displayMedium,),
                    SizedBox(height: 20,),
                    CustomTextFormField(
                      onChanged: (value) {
                        setState(() {
                          foodName = value;
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "음식 이름은 필수입니다.";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                      hint: "음식 이름을 입력해주세요.",
                      prefixIcon: IconlyBroken.arrow_right,
                    ),
                    const SizedBox(height: 20,),
                    Text('설명',style: Theme.of(context).textTheme.displayMedium,),
                    const SizedBox(height: 20,),
                    CustomTextFormField(
                      onChanged: (value) {
                        setState(() {
                          foodDescription = value;
                        });
                      },
                      obscureText: false,
                      hint: "한 줄로 소개해주세요.",
                      prefixIcon: IconlyBroken.arrow_right,
                    ),
                    SizedBox(height: 20,),
                    Text('카테고리',style: Theme.of(context).textTheme.displayMedium,),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: outline),
                      ),
                      padding: EdgeInsets.only(left: 50),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: foodCategory,
                          items: _valueList.map(
                                (value) {
                              return DropdownMenuItem (
                                value: value,
                                child: Text(value,style: const TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              foodCategory = value!;
                            });
                          },
                        ),
                      )
                    ),

                    SizedBox(height: 20,),
                    CustomButton(onTap: (){
                      if (imageFile == null){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 15,),
                                  Container(
                                    padding: EdgeInsets.all(20.0),
                                    child: Text(
                                      '이름과 커버사진은 필수사항 입니다.',
                                      style: TextStyle(color: mainText, fontSize: 18),
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Divider(
                                    color: Colors.grey,
                                    height: 1,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(); // 대화 상자 닫기
                                          },
                                          child: Text('확인', style: TextStyle(color: SecondaryText)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );

                      }
                      if (nextKey.currentState!.validate()) {
                        Get.to(SecondUploadScreen(
                          imageFile: imageFile,
                          foodName: foodName,
                          foodDescription: foodDescription,
                          foodCategory: foodCategory,
                        ));
                      }
                    }, text: '다음',color: Colors.black,),
                  ],
                )
              ],
            ),
          )
        ),
        )));
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo1 = await picker.pickImage(source: ImageSource.gallery);
    if (photo1 != null) {
      setState(() {
        imageFile = photo1;
      });
    }
  }
}

