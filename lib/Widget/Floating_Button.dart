import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget? floatingButtons() {
  return SpeedDial(
    animatedIcon: AnimatedIcons.menu_close,
    visible: true,
    curve: Curves.bounceIn,
    backgroundColor: Colors.indigo.shade900,
    children: [
      SpeedDialChild(
          child: const Icon(Icons.save, color: Colors.white),
          label: "저장",
          labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 13.0),
          backgroundColor: Colors.indigo.shade900,
          labelBackgroundColor: Colors.indigo.shade900,
          onTap: () {
            AlertDialog(
              content: Container(
                height: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('개인의 취향에 따라 GPT 레시피를 수정해주세요!',style: TextStyle(fontSize: 20)),
                    TextField(
                      decoration: InputDecoration(
                          hintText: '입력해주세요!',
                          border: OutlineInputBorder()
                      ),
                    )
                  ],
                ),
              ),
              insetPadding: const  EdgeInsets.fromLTRB(0,80,0, 80),
              actions: [
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                  },
                ),
              ],
            );
          }),
      SpeedDialChild(
        child: const Icon(
          Icons.auto_fix_high,
          color: Colors.white,
        ),
        label: "수정",
        backgroundColor: Colors.indigo.shade900,
        labelBackgroundColor: Colors.indigo.shade900,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
        onTap: () {},
      )
    ],
  );
}