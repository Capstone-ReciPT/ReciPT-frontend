import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/gpt/GPTRecipeServer.dart';
import 'package:recipt/Server/gpt/GptEditServer.dart';
import 'package:recipt/Server/gpt/GptRecipeSave.dart';
import 'package:recipt/main.dart';

Widget? floatingButtons(context) {
  final TextEditingController _controller = TextEditingController();

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
            showDialog(
              context: context,
              builder: (context) {
                return FutureBuilder<bool>(
                  future: fetchGPTRecipeSave(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // 데이터를 가져오는 중
                      return AlertDialog(
                        content: Container(
                          height: 130,
                          child: Column(
                            children: [
                              Text('저장 중 입니다.',style: Theme.of(context).textTheme.displayLarge,),
                              SizedBox(height: 10,),
                              Container(
                                  width: 150,
                                  height: 80,
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage("assets/icons/voice2.gif"),
                                    radius: 40.0,
                                  )
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      // 데이터 가져오기 성공
                      return AlertDialog(
                        title: Text('저장되었습니다!', style: Theme.of(context).textTheme.displayLarge),
                        actions: [
                          TextButton(
                            child: Text('확인'),
                            onPressed: () {
                              fetchGPTRefresh();
                              Get.offAll(MyApp());
                            } // 대화 상자 닫기
                          )
                        ],
                      );
                    } else {
                      // 데이터 가져오기 실패 또는 오류
                      return AlertDialog(
                        title: Text('오류가 발생했습니다.'),
                        actions: [
                          TextButton(
                            child: Text('확인'),
                            onPressed: () => Navigator.of(context).pop(false), // 대화 상자 닫기
                          )
                        ],
                      );
                    }
                  },
                );
              },
            );
          }),
      // SpeedDialChild(
      //   child: const Icon(
      //     Icons.auto_fix_high,
      //     color: Colors.white,
      //   ),
      //   label: "수정",
      //   backgroundColor: Colors.indigo.shade900,
      //   labelBackgroundColor: Colors.indigo.shade900,
      //   labelStyle: const TextStyle(
      //       fontWeight: FontWeight.w500, color: Colors.white, fontSize: 13.0),
      //   onTap: () {
      //     showDialog(context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           content: Container(
      //             height: 210,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Text('개인의 취향에 따라',style: Theme.of(context).textTheme.displayMedium),
      //                 SizedBox(height: 12,),
      //                 Text('GPT 레시피를 수정해주세요!',style: Theme.of(context).textTheme.displayMedium),
      //                 SizedBox(height: 30,),
      //                 TextField(
      //                   controller: _controller,
      //                   decoration: InputDecoration(
      //                       hintText: '입력해주세요!',
      //                       border: OutlineInputBorder()
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           actions: [
      //             TextButton(
      //               child: Text('확인'),
      //               onPressed: () async {
      //                 FutureBuilder(
      //                     builder: builder)
      //                 await fetchGPtRecipeEdit(_controller.value.toString();
      //                 if(){
      //                   Navigator.of(context).pop(false); // 대화 상자 닫기
      //                   showDialog(
      //                       context: context,
      //                       builder: (context) {
      //                         return AlertDialog(
      //                           title: Text('수정되었습니다!',style: Theme.of(context).textTheme.displayLarge,),
      //                           actions: [
      //                             TextButton(
      //                                 child: Text('확인'),
      //                                 onPressed: () {}
      //                             )
      //                           ],
      //                         );
      //                       }
      //                   );
      //                 }
      //               },
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      // )
    ],
  );
}