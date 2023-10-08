
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:recipt/View/Search/SearchPage.dart';
import 'package:recipt/constans/colors.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    required this.onTap,
    this.color = primary,
    required this.text,
    this.colorBorder,
    this.textColor,
    this.height = 56,
    Key? key,
  }) : super(key: key);
  String? text;
  Color? color;
  Function() onTap;
  Color? colorBorder;
  Color? textColor;
  double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
            border: colorBorder == null
                ? null
                : Border.all(color: colorBorder!, width: 2),
          ),
          child: Text(
            text!,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonToSearchTab extends StatelessWidget {
  const ButtonToSearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20,left: 5,right: 5,bottom: 10),
      child: TextButton(
        onPressed: (){
          Get.to(SearchPage());
        },
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    side: BorderSide(color: outline)
                )
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(IconlyLight.search,color: mainText, size: 24,),
              SizedBox(width: 12,),
              Text('검색',style: TextStyle(fontFamily: "Inter", fontSize: 17, fontWeight: FontWeight.w500,color: mainText)),
            ],
          ),
        ),
      ),
    );
  }
}