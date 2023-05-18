
import 'package:flutter/material.dart';
import 'package:recipt/Widget/CustomSlider.dart';
import 'package:recipt/constans/colors.dart';

class CustomCategoriesList extends StatefulWidget {
  const CustomCategoriesList({Key? key}) : super(key: key);

  @override
  State<CustomCategoriesList> createState() => _CustomCategoriesListState();
}

class _CustomCategoriesListState extends State<CustomCategoriesList> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "카테고리",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        Row(
          children: [
            menuButton(
                onTap: () {
                  setState(() {
                    _index = 0;
                  });
                },
                color: _index == 0 ? Colors.black : form,
                text: "모두",
                textColor: _index == 0 ? Colors.white : SecondaryText,),
            menuButton(
                onTap: () {
                  setState(() {
                    _index = 1;
                  });
                },
                color: _index == 1 ? Colors.black : form,
                text: "야채",
                textColor: _index == 1 ? Colors.white : SecondaryText,
            ),
            menuButton(
                onTap: () {
                  setState(() {
                    _index = 2;
                  });
                },
                color: _index == 2 ? Colors.black : form,
                text: "고기",
                textColor: _index == 2 ? Colors.white : SecondaryText,),

          ],
        ),
      ],
    );
  }

  menuButton(
      {required String text,
        required Color color,
        required Color textColor,
        required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: 65,
          height: 45,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}