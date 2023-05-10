import 'package:flutter/material.dart';
import 'package:recipt/View/Other/Start/Sign_in_screen.dart';
import 'package:recipt/Widget/Custom_button.dart';
import 'package:get/get.dart';
class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset('assets/Banner/Onboarding.png',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 35,),
          Expanded(
            child: Column(
              children: [
                Text('ReciPT 시작하기',style: Theme.of(context).textTheme.displayLarge,),
                SizedBox(height: 16,),
                SizedBox(
                  width: 210,
                    child: Text('AI 기술을 사용해 더욱 편리하게 요리를 즐겨보세요!',style: Theme.of(context).textTheme.bodyLarge,)
                ),
                SizedBox(height: 45,),
                CustomButton(
                  text: "시작하기",
                  color: Colors.black,
                  onTap: (){
                    Get.to(SignInScreen());
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
