
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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


class TtsController extends GetxController {
  var speakNow = true.obs;

  final FlutterTts tts = FlutterTts();

  Future<void> speakText(String text) async{
    speakNow.value = false;
    await tts.setLanguage('ko-KR');
    await tts.setSpeechRate(0.4);
    await tts.speak(text);
    speakNow.value =true;
  }

  void stopTTS() async{
    await tts.stop();
  }
}






