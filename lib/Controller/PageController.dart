
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';



class Controller extends GetxController{
  var count= 0.obs;
  var currentDotIndex = 0.obs;
  var currentTab = 0.obs;
  var bannerIndex = 0.obs;
  var favorite = false.obs;

  changeDotIndex(index){
    currentDotIndex.value = index;
  }
  changeTab(index){
    currentTab.value = index;
  }
  changeBannerIndex(index){
    bannerIndex.value = index;
    print(bannerIndex.value);
  }
  changeLikeButtonState(){
    favorite.value = !favorite.value;
    update();
  }


}

class CookingMenuController extends GetxController{
  var index = 0.obs;
  var pageLimit;
  nextIndex(){
    index +=1;
    update();
  }

  prevIndex(){
    index-=1;
    update();
  }

  fixIndex(){
    index.value = pageLimit-1;
    update();
  }
}

class SttController extends GetxController {
  final CookingMenuController cookingMenuController = Get.find();
  final TtsController ttsController = Get.put(TtsController());
  final SpeechToText _speech = SpeechToText();
  bool isProcessingCommand = false;
  bool showFlag = true;
  var buffer;
  var context;
  var nowListen= false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initializeSpeechToText();
  }

  void canShowFlag(){
    showFlag = true;
    update();
  }

  void cantShowFlag(){
    showFlag = false;
    update();
  }

  Future<void> _initializeSpeechToText() async {
    if (!_speech.isAvailable) {
      bool available = await _speech.initialize();
      if (available) {
        print("Speech to text initialized");
      } else {
        print("Speech to text not available");
      }
    }
  }
  void show() {
    if(showFlag){
      startListening();
      Timer(Duration(seconds: 3 ), show);
    } else{
      stopListening();
    }

  }
  Future<void> startListening() async {
    await _speech.listen(
      listenFor: Duration(hours: 24),
      onResult: (val){
        nowListen.value = true;
          buffer = [];
          buffer.add(val.recognizedWords);
          processVoiceCommand(buffer);
        },
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }
  //테스트 코드
  int countNum = 0;
  void increaseCountNum(){
    countNum +=1;
    update();
  }
  Future<void> processVoiceCommand(command) async {
    if (isProcessingCommand) {
      return;
    }
    else {
      print(command);
      await Future.delayed(Duration(seconds: 2));
      isProcessingCommand = true;
      if (command.contains('시작') || command.contains('시장')
          || command.contains('짝')
          || (command.contains('시') && command.contains('작'))
      ) {
        cantShowFlag();
        await stopListening();

        // increaseCountNum();
        // if(countNum > 1){
        //   ttsController.stopTTS();
        //   await ttsController.speakText(context[cookingMenuController.index.value]);
        //   countNum = 0;
        //   canShowFlag();
        //   show();
        // }
        ttsController.stopTTS();
        await ttsController.speakText(context[cookingMenuController.index.value]);
        canShowFlag();
        show();

      }
      else if (command.contains('다음') || command.contains('다응')
          || (command.contains('다') && command.contains('음'))) {
        cantShowFlag();
        increaseCountNum();
        if(countNum > 1){
          ttsController.stopTTS();
          cookingMenuController.nextIndex();
          if (cookingMenuController.index.value >= context.length) {
            cookingMenuController.fixIndex();
          }
          await ttsController.speakText(context[cookingMenuController.index.value]);
          countNum = 0;
        }
        canShowFlag();
      }
      else if (command.contains('이전') || command.contains('이정')
          || (command.contains('이') && command.contains('전'))) {
        cantShowFlag();
        increaseCountNum();
        if(countNum > 1){
          ttsController.stopTTS();
          cookingMenuController.prevIndex();
          if (cookingMenuController.index.value <= 0) {
            cookingMenuController.index.value = 0;
          }
          await ttsController.speakText(context[cookingMenuController.index.value]);
          countNum = 0;
        }
        canShowFlag();
      }

      //명령어 처리 완료
      nowListen.value = false;
      buffer = [];
      isProcessingCommand = false;
    }
  }
}

class TtsController extends GetxController {

  final FlutterTts tts = FlutterTts();

  Future<void> speakText(String text) async{
    await tts.setLanguage('ko-KR');
    await tts.setSpeechRate(0.4);
    await tts.speak(text);
  }

  void stopTTS() async{
    await tts.stop();
  }
}






