
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:recipt/Controller/IngredientController.dart';
import 'package:recipt/View/api/Yolo/addIngredient.dart';
import 'package:recipt/main.dart';


class FridgeRecipeSuggest extends StatefulWidget {
  FridgeRecipeSuggest({Key? key}) : super(key: key);

  @override
  State<FridgeRecipeSuggest> createState() => _FridgeRecipeSuggestState();
}

class _FridgeRecipeSuggestState extends State<FridgeRecipeSuggest> {
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;
  File? imageFile;
  int imageHeight = 1;
  int imageWidth = 1;
  bool isLoaded = false;
  bool isDetected = false;
  bool isFailed = false;
  List<String> tagList = [];

  @override
  void initState() {
    super.initState();
    vision = FlutterVision();
    loadYoloModel().then((value) {
      setState(() {
        yoloResults = [];
        isLoaded = true;
      });
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await vision.closeYoloModel();
  }

  final IngreController ingreController = Get.put(IngreController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (!isLoaded) {
      return SafeArea(child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ));
    }
    return SafeArea(child: Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          imageFile != null ? Container(
            width: 200,
              height: 100,
              child: Image.file(imageFile!,width: 200,height: 100,))
              : YoloFirstPage2(),
          ...displayBoxesAroundRecognizedObjects(size),
          isDetected ?
          Positioned(
            bottom: 40,
            left: 90,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 2,color: Colors.black45)
              ),
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: (){
                  extractTags();
                  setState(() {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AnimatedPadding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        duration: const Duration(milliseconds: 100),  // Specify the duration of the animation
                        child: AddIngredient(context: context,),
                      ),
                    );
                  });
                },
                child: Text('다음으로',style: Theme.of(context).textTheme.displayLarge,),
              ),
            ),
          ) : SizedBox(),
          isFailed ? Positioned(
            bottom: 40,
            left: 90,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 2,color: Colors.black45)
              ),
              width: 200,
              height: 50,
              child: TextButton(
                onPressed: (){
                  Get.back();
                },
                child: Text('다시하기',style: Theme.of(context).textTheme.displayLarge,),
              ),
            ),
          ) : SizedBox(),
        ]
      ),
    ),
    );
  }
  extractTags() {
    for (var result in yoloResults) {
      String tag = result['tag'];
      ingreController.listAdd(tag);
    }
    print(ingreController.ingreList);
  }

  YoloFirstPage2(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/ChatGPT_logo.png',width: 150,height: 150,),
          SizedBox(height: 50,),
          Container(
              width: 250,
              child: Text('사진 / 카메라로 인식한 식재료로 \n\n GPT가 음식을 추천해드립니다!',style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 18),)
          ),
          SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: (){
                  takeImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_outlined),
                      SizedBox(height: 5,),
                      Text('카메라'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  pickImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(width: 1)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image),
                      SizedBox(height: 5,),
                      Text('갤러리'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30,),
        ],
    );
  }
  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
        labels: 'assets/yolo/coco2.txt',
        modelPath: 'assets/yolo/model.tflite',
        modelVersion: "yolov8",
        numThreads: 2,
        useGpu: true);
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
        yoloOnImage();
      });
    }
  }
  Future<void> takeImage() async {
    final ImagePicker picker = ImagePicker();
    // Capture a photo
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        imageFile = File(photo.path);
        yoloOnImage();
      });
    }

  }

  yoloOnImage() async {
    yoloResults.clear();
    Uint8List byte = await imageFile!.readAsBytes();
    final image = await decodeImageFromList(byte);
    imageHeight = image.height;
    imageWidth = image.width;
    final result = await vision.yoloOnImage(
        bytesList: byte,
        imageHeight: image.height,
        imageWidth: image.width,
        iouThreshold: 0.8,
        confThreshold: 0.4,
        classThreshold: 0.5);
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
        isDetected = true;
      });
    }
    else{
      setState(() {
        isDetected = false;
        isFailed = true;
      });
    }
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];

    double factorX = screen.width / (imageWidth);
    double imgRatio = imageWidth / imageHeight;
    double newWidth = imageWidth * factorX;
    double newHeight = newWidth / imgRatio;
    double factorY = newHeight / (imageHeight);

    double pady = (screen.height - newHeight) / 2;

    Color colorPick = const Color.fromARGB(255, 50, 233, 30);

    return yoloResults.map((result) {
      return Positioned(
        left: result["box"][0] * factorX,
        top: result["box"][1] * factorY + pady,
        width: (result["box"][2] - result["box"][0]) * factorX,
        height: (result["box"][3] - result["box"][1]) * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ${(result['box'][4] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = colorPick,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }


}
