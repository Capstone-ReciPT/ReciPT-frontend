
import 'package:flutter/material.dart';
import 'package:recipt/constans/colors.dart';

class CustomTextFieldInUpload extends StatelessWidget {
  CustomTextFieldInUpload(
      {Key? key,
        this.maxLines = 1,
        this.icon,
        required this.hint,
        this.radius = 10})
      : super(key: key);
  int maxLines;
  IconData? icon;
  String hint;
  double radius;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        icon: icon == null ? null : Icon(icon),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: SecondaryText),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: outline)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: outline)),
      ),
    );
  }
}

class CustomTextFieldInUpload2 extends StatelessWidget {
  CustomTextFieldInUpload2(
      {Key? key,
        this.maxLines = 1,
        this.icon,
        required this.hint,
        this.radius = 10,
        required this.controller})  // Add this line
      : super(key: key);
  int maxLines;
  IconData? icon;
  String hint;
  double radius;
  final TextEditingController controller;  // Add this line

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,  // Connect the controller here
      maxLines: maxLines,
      decoration: InputDecoration(
        icon: icon == null ? null : Icon(icon),
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: SecondaryText),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: outline)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: outline)),
      ),
    );
  }
}
