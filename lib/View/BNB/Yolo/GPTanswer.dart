import 'dart:ui';

import 'package:flutter/material.dart';

class GPTanswer extends StatelessWidget {
  const GPTanswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width*1.0,
            height: MediaQuery.of(context).size.height*1.0,
            child: Image.asset(''),
          ),
          Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 10,sigmaX: 20),
                child: SizedBox(),
              )
          ),

        ],
      ),
    ));
  }
}
