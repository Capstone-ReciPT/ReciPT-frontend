
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

var text = [
  '떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.',
  '떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.2',
  '떡을 물에 행궈서 한번 데쳐주세요\n떡이 좀 더 야들야들해집니다.3',
];

class CookingMenuController extends GetxController{
  var index = 0.obs;
  nextIndex(){
    index+=1;
    update();
  }

  prevIndex(){
    index-=1;
    update();
  }

  fixIndex(){
    index.value = text.length-1;
    update();
  }
}

class SttController extends GetxController {
  final CookingMenuController cookingMenuController = Get.find();
  final TtsController ttsController = Get.put(TtsController());
  final SpeechToText _speech = SpeechToText();
  var text1 = '임시'.obs;
  var text2 = '임시'.obs;
  bool isProcessingCommand = false;
  bool showFlag = true;
  var buffer = [];
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
      Timer(Duration(seconds: 1), show);
    }

  }
  Future<void> startListening() async {
    await _speech.listen(
      listenFor: Duration(hours: 24),
      onResult: (val){
        buffer = [];
          buffer.add(val.recognizedWords);
          processVoiceCommand(buffer);
          },
    );
  }

  Future<void> stopListening() async {
    await _speech.stop();
  }

  Future<void> processVoiceCommand(command) async {
    if (isProcessingCommand) {
      return;
    }
    else {
      isProcessingCommand = true;
      if (command.contains('시작') || command.contains('시장')
          || (command.contains('시') && command.contains('작'))) {
        text1.value = buffer[0];
        ttsController.stopTTS();
        await ttsController.speakText(text[cookingMenuController.index.value]);
      }
      if (command.contains('다음') || command.contains('다응')
          || (command.contains('다') && command.contains('음'))) {
        text1.value = '다음';
        ttsController.stopTTS();
        cookingMenuController.nextIndex();
        if (cookingMenuController.index.value >= text.length) {
          cookingMenuController.fixIndex();
        } else {
          await ttsController.speakText(text[cookingMenuController.index.value]);
        }
      }
      if (command.contains('이전') || command.contains('이정')
          || (command.contains('이') && command.contains('전'))) {
        text1.value = '이전';
        ttsController.stopTTS();
        cookingMenuController.prevIndex();
        if (cookingMenuController.index.value <= 0) {
          cookingMenuController.index.value = 0;
        } else {
          await ttsController.speakText(
              text[cookingMenuController.index.value]);
        }
      }

      //명령어 처리 완료
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


