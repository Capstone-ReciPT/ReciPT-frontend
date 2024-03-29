
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipt/Server/Upload/UploadRecipeServer.dart';
import 'package:recipt/Server/gpt/GptLoadRecipeAllServer.dart';
import 'package:recipt/Widget/CustomTextFieldInUpload.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';
import 'package:recipt/main.dart';

import '../../../constans/colors.dart';

class GptUploadAll extends StatefulWidget {
  const GptUploadAll({
    Key? key,
    this.imageFile,
    this.foodName,
    this.foodDescription,
    this.foodCategory,
    this.gptId
  }) : super(key: key);

  final imageFile;
  final foodName;
  final foodDescription;
  final foodCategory;
  final gptId;
  @override
  State<GptUploadAll> createState() => _GptUploadAllState();
}

class _GptUploadAllState extends State<GptUploadAll> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchLoadGptRecipeAll(widget.gptId).then((data) {
      setState(() {
        for (var ingredient in data.ingredient) {
          ingredients.add(ingredient);
          ingreControllers.add(TextEditingController(text: ingredient));
        }
        for (var step in data.context) {
          steps.add(step);
          recipeControllers.add(TextEditingController(text: step));
        }
      });
    });
  }
  List ingredients = [];
  List steps = [];
  List ingreControllers = [];
  List recipeControllers = [];
  List _imageFiles = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.offAll(MyApp());
                            },
                            child: Text(
                              "취소",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(color: Secondary),
                            )),
                        Text(
                          "2/2",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: SecondaryText),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "재료",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Text(
                          "왼쪽으로 밀어 삭제",
                          style: TextStyle(
                              color: SecondaryText
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: ingreControllers.length,
                        itemBuilder: (context, index) =>
                            enterIngerediant(index)),
                    ingredientsButton(),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "레시피",
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                recipeControllers.add(TextEditingController());
                                steps.add(step(1));
                              });
                            },
                            icon: const Icon(Icons.add))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: recipeControllers.length,
                      itemBuilder: (context, index) => step(index),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: CustomButton(
                              onTap: () {
                                Get.back();
                              },
                              text: "이전",
                              color: form,
                              textColor: mainText,
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: CustomButton(
                              onTap: () async {
                                List<String> ingredients = getControllersValue(ingreControllers);
                                List<String> recipes = getControllersValue(recipeControllers);
                                print(_imageFiles);
                                if((ingreControllers.length != ingredients.length)
                                    ||  (recipeControllers.length != recipes.length)
                                    || (_imageFiles.length != recipeControllers.length)
                                ){
                                  return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Color(0xFFFFFFFF),
                                          title: Text(
                                            '모든 항목을 채워 넣어주세요! (사진 포함)',
                                            style: TextStyle(color: mainText,fontSize: 14),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                                                  Navigator.of(context).pop(false); // 대화 상자 닫기
                                                },
                                                child: Text('확인',style: TextStyle(color: SecondaryText),)),
                                          ],
                                        );
                                      }) ?? false; // 취소 버튼이 눌릴 경우 false 반환
                                }
                                if (await fetchUploadRecipe(
                                    widget.imageFile,
                                    widget.foodName,
                                    widget.foodDescription,
                                    widget.foodCategory,
                                    ingredients,
                                    recipes,
                                    _imageFiles)){
                                  openDialog();
                                } else{
                                  await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Color(0xFFFFFFFF),
                                          title: Column(
                                            children: [
                                              Text(
                                                '레시피 등록에 실패했습니다.',
                                                style: TextStyle(color: mainText,fontSize: 18),
                                              ),
                                              SizedBox(height: 12,),
                                              Text(
                                                '다시 시도해주세요!',
                                                style: TextStyle(color: mainText,fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                                                  Navigator.of(context).pop(false); // 대화 상자 닫기
                                                },
                                                child: Text('확인',style: TextStyle(color: SecondaryText),)),
                                          ],
                                        );
                                      }) ?? false;
                                }

                              },
                              text: "다음",color: Colors.black,)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// enter engrediant section
  enterIngerediant(int index) {
    return Dismissible(
      key: GlobalKey(),
      direction: ingredients.isNotEmpty
          ? DismissDirection.endToStart
          : DismissDirection.none,
      onDismissed: (direction) {
        setState(() {
          if(ingredients[index] != ''){
            ingredients.removeAt(index);
          }
          ingreControllers.removeAt(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: CustomTextFieldInUpload(
          controller: ingreControllers[index],
          radius: 30,
          hint: "재료를 입력해주세요.",
          icon: Icons.drag_indicator,
        ),
      ),
    );
  }

  ingredientsButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            ingredients.add(enterIngerediant(1));
            ingreControllers.add(TextEditingController());
            print(ingredients);
            print(ingreControllers);
          });
        },
        child: Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: SecondaryText),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.add),
                Text(
                  "재료 추가",
                  style: TextStyle(
                      fontSize: 15,
                      color: mainText,
                      fontWeight: FontWeight.w500),
                )
              ],
            )),
      ),
    );
  }

  step(int index) {
    return Dismissible(
      direction: steps.length > 1
          ? DismissDirection.endToStart
          : DismissDirection.none,
      key: GlobalKey(),
      onDismissed: (d) {
        setState(() {
          steps.removeAt(index);
          recipeControllers.removeAt(index);
        });
      },
      child: Stack(
        children: [
          Column(
            children: [
              CustomTextFieldInUpload(
                controller: recipeControllers[index],
                hint: "사진과 함께 단계별로 설명해주세요.",
                icon: Icons.drag_indicator,
                maxLines: 4,
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 10, left: 35),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: form,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: _imageFiles.length > index
                      ? Image.file(File(_imageFiles[index].path))
                      : const Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: mainText,
                  ),
                ),
                onTap: (){
                  pickImage(index);
                },
              )
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundColor: mainText,
              radius: 12,
              child: Text(
                "${index + 1}",
                style: TextStyle(fontSize: 12),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo1 = await picker.pickImage(source: ImageSource.gallery);
    if (photo1 != null) {
      setState(() {
        // 만약 이미지를 추가할 인덱스가 _imageFiles 리스트의 길이보다 크다면 먼저 해당 인덱스까지 null로 채워줍니다.
        while (_imageFiles.length <= index) {
          _imageFiles.add(null);
        }
        _imageFiles[index] = photo1;
      });
    }
  }

  Future openDialog() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            padding: const EdgeInsets.all(20),
            height: 450,
            width: 327,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/icons/goodgood.png"),
                SizedBox(height: 20,),
                Text(
                  "업로드 성공!",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "성공적으로 업로드 되었습니다.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "프로필에서 확인하세요!",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                CustomButton(
                  onTap: () {
                    Get.to(MyApp());
                  },
                  text: "처음으로",color: Colors.black,)
              ],
            ),
          ),
        ));

  }

  List<String> getControllersValue(List<dynamic> controllers) {
    List<String> res = [];
    for (TextEditingController tec in controllers) {
      if(tec.value.text == '') continue;
      res.add(tec.value.text);
    }
    print(res);
    return res;
  }
}




