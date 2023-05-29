import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Controller/IngredientController.dart';
import 'package:recipt/View/BNB/Yolo/GPTanswer.dart';
import 'package:recipt/Widget/CustomTextFieldInUpload.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:recipt/constans/colors.dart';

import 'SelectedRecipePage.dart';


class AddIngredient extends StatefulWidget {
  const AddIngredient({Key? key, required BuildContext context}) : super(key: key);

  @override
  State<AddIngredient> createState() => _AddIngredientState();
}

class _AddIngredientState extends State<AddIngredient> {
  List ingrediants = [1];
  final IngreController ingreController = Get.put(IngreController());
  List<TextEditingController> ingrediantControllers = [TextEditingController()];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "식재료 추가",
              style: Theme
                  .of(context)
                  .textTheme
                  .displayLarge,
            ),
            SizedBox(height: 20,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingrediants.length,
                itemBuilder: (context, index) =>
                    _enterIngerediant(index)),
            addIngreButton(),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                      onTap: () {
                        ingreController.listClear();
                        Navigator.pop(context);
                      },
                      text: "취소",
                      color: form,
                      textColor: mainText,
                    )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: CustomButton(
                      onTap: () {
                        // Clear the list first
                        for (var controller in ingrediantControllers) {
                          ingreController.listAdd(controller.text);
                        }
                        print(ingreController.listPush());
                        Get.to(GPTanswer(GPTSuggestListString: ingreController.listPush(),));
                        ingreController.listClear();
                      },
                      color: Colors.black,
                      text: "완료",
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  addIngreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            ingrediants.add(ingrediants.length + 1);
            ingrediantControllers.add(TextEditingController());
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


  _enterIngerediant(int index) {
    return Dismissible(
      key: ValueKey(ingrediants[index]),  // Provide a unique key for Dismissible
      direction: ingrediants.length > 1
          ? DismissDirection.endToStart
          : DismissDirection.none,
      onDismissed: (direction) {
        setState(() {
          ingrediants.removeAt(index);
          ingrediantControllers[index].dispose();
          ingrediantControllers.removeAt(index);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: CustomTextFieldInUpload2(
          key: ValueKey(ingrediants[index]),  // Provide a unique key for CustomTextFieldInUpload
          controller: ingrediantControllers[index],  // Connect the controller here
          radius: 30,
          hint: "재료를 입력해주세요.",
          icon: Icons.drag_indicator,
        ),
      ),
    );
  }

}
