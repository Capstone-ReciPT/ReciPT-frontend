
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipt/constans/colors.dart';

class CustomSlider extends StatefulWidget {
  CustomSlider({Key? key,this.DurationName}) : super(key: key);

  final DurationName;
  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  double slider = 30;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.DurationName,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "< 10",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: mainText),
                  ),
                  Text(
                    "30",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: mainText),
                  ),
                  Text(
                    "> 50",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: mainText),
                  ),
                ],
              ),
            ),
            Slider(
                divisions: 2,
                activeColor: Colors.black45,
                thumbColor: Colors.black,
                max: 60,
                min: 10,
                value: slider,
                onChanged: (value) {
                  setState(() {
                    slider = value;
                  });
                })
          ],
        )
      ],
    );
  }
}