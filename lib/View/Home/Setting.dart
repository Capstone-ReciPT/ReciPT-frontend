import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/JWT/jwt.dart';
import 'package:recipt/Server/login/LoginServer.dart';
import 'package:recipt/View/login/StartScreen.dart';
import 'package:recipt/constans/colors.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: mainText,
                            )
                        ),
                        SizedBox(width: 90,),
                        Text('설정',style: Theme.of(context).textTheme.displayLarge,)
                      ]
                  ),
                ),
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   itemCount: 5,
              //   itemBuilder: (context, index) {
              //     return Container(
              //         decoration: BoxDecoration(border: Border(
              //             bottom: BorderSide(
              //               color: Colors.grey, width: 1,
              //             )
              //         )),
              //         margin: EdgeInsets.only(bottom: 10),
              //         child: TextButton(
              //           child: Row(
              //             children: [
              //               SizedBox(width: 20,),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text('1',style: Theme.of(context).textTheme.displayLarge,),
              //                 ],
              //               ),
              //             ],
              //           ),
              //           onPressed: (){
              //           },
              //         )
              //     );
              //   },
              // ),
              Container(
                  decoration: BoxDecoration(border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, width: 1,
                      )
                  )),
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextButton(
                    child: Row(
                      children: [
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('로그아웃',style: Theme.of(context).textTheme.displayLarge,),
                          ],
                        ),
                      ],
                    ),
                    onPressed: () async {
                      print(getJwt());
                      if(await logout()){
                        await removeJwt();
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFFFFFFFF),
                                title: Text(
                                  '로그아웃 되었습니다.',
                                  style: TextStyle(color: mainText),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        //onWillpop에 true가 전달되어 앱이 종료 된다.
                                        Navigator.pop(context, true);
                                      },
                                      child: Text('확인',style: TextStyle(color: SecondaryText),)),
                                ],
                              );
                            });
                        Get.offAll(StartScreen());
                      }

                    },
                  )
              ),
            ],
          ),
        )));
  }
}