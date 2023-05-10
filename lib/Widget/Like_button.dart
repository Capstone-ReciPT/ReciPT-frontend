import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:like_button/like_button.dart';
import 'package:recipt/Controller/PageController.dart';

class LikeButtonWidget extends StatelessWidget {
  LikeButtonWidget({Key? key}) : super(key: key);

  final Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: 40,
      likeBuilder: (bool isLiked) {
        return ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Container(
            clipBehavior: Clip.hardEdge,
            width: 32,
            height: 32,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7)
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white.withOpacity(0.10),
                ),
                child: Center(
                  child: isLiked
                      ? const Icon(IconlyBold.heart,color: Colors.red,)
                      : const Icon(IconlyBroken.heart,color: Colors.black45,)
                ),
              ),
            ),
          ),
        );
      },
      onTap: controller.changeLikeButtonState(),
    );
  }
}
