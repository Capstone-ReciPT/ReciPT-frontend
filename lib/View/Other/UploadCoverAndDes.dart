import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:recipt/View/Other/UploadRecipeAll.dart';
import 'package:recipt/Widget/Custom_button.dart';
import '../../constans/colors.dart';
import 'package:recipt/Widget/CustomTextFieldInUpload.dart';
class UploadTab extends StatelessWidget {
  const UploadTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView( child: Padding(
        padding: EdgeInsets.all(20),
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
                addCoverPhoto(),
                SizedBox(height: 20,),
                Text('음식 이름',style: Theme.of(context).textTheme.displayMedium,),
                SizedBox(height: 20,),
                CustomTextFieldInUpload(
                  hint: '음식 이름을 입력하세요.',
                  radius: 30,
                ),
                const SizedBox(height: 20,),
                Text('설명',style: Theme.of(context).textTheme.displayMedium,),
                const SizedBox(height: 20,),
                CustomTextFieldInUpload(
                  hint: '한줄로 소개해주세요.',
                  maxLines: 4,
                ),
                SizedBox(height: 20,),
                CustomButton(onTap: (){
                  Get.to(SecondUploadScreen());
                }, text: '다음',color: Colors.black,),
              ],
            )
          ],
        ),
      ),
    )));
  }

  addCoverPhoto(){
    return InkWell(
      onTap: (){},
      child: DottedBorder(
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
    );
  }
}
