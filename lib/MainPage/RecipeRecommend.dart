import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_vision/flutter_vision.dart';

class CameraExample extends StatefulWidget {
  const CameraExample({Key? key}) : super(key: key);

  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  File? _image;
  final picker = ImagePicker();
  List? _outputs;
  int imageHeight = 1;
  int imageWidth = 1;

  FlutterVision vision = FlutterVision();
  // 앱이 실행될 때 loadModel 호출
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  // 모델과 label.txt를 가져온다.
  loadModel() async {
    await vision.loadYoloModel(
        labels: 'assets/yolo/yolov2_tiny.txt',
        modelPath: 'assets/yolo/yolov2_tiny.tflite',
        modelVersion: "yolov5",
        numThreads: 1,
        useGpu: false);
  }

  // 비동기 처리를 통해 카메라와 갤러리에서 이미지를 가져온다.
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    if (image != null) {
      final originalImage = img.decodeImage(File(image.path).readAsBytesSync());
      final resizedImage = img.copyResize(originalImage!, width: 416, height: 416);
      // Convert the resized image back to a File
      final resizedImagePath = File(image.path).parent.path + '/resized_image.jpg';
      final resizedImageFile = File(resizedImagePath);
      await resizedImageFile.writeAsBytes(img.encodeJpg(resizedImage));

      setState(() {
        _image = File(resizedImagePath); // 저장된 이미지를 _image에 저장
      });
      await classifyImage(File(resizedImagePath)); // 가져온 이미지를 분류하기 위해 await 사용
    }
  }

  // 이미지 분류
  Future classifyImage(File imageFile) async {
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
    print(result);
    setState(() {
      _outputs = result;
    });
  }

  // 이미지를 보여주는 위젯
  Widget showImage() {
    return Container(
        color: const Color(0xffd0cece),
        margin: EdgeInsets.only(left: 95, right: 95),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
            child: _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path))));
  }

  recycleDialog() {
    _outputs != null
        ? showDialog(
        context: context,
        barrierDismissible:
        false, // barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        builder: (BuildContext context) {
          return AlertDialog(
            // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  _outputs![0]['label'].toString().toUpperCase(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    background: Paint()..color = Colors.white,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: new ElevatedButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        })
        : showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "데이터가 없거나 잘못된 이미지 입니다.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: new ElevatedButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        backgroundColor: const Color(0xfff4f3f9),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Classify',
              style: TextStyle(fontSize: 25, color: const Color(0xff1ea271)),
            ),
            SizedBox(height: 25.0),
            showImage(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // 카메라 촬영 버튼
                FloatingActionButton(
                  child: Icon(Icons.add_a_photo),
                  tooltip: 'pick Iamge',
                  onPressed: () async {
                    await getImage(ImageSource.camera);
                    recycleDialog();
                  },
                ),

                // 갤러리에서 이미지를 가져오는 버튼
                FloatingActionButton(
                  child: Icon(Icons.wallpaper),
                  tooltip: 'pick Iamge',
                  onPressed: () async {
                    await getImage(ImageSource.gallery);
                    recycleDialog();
                  },
                ),
              ],
            )
          ],
        ));
  }

  // 앱이 종료될 때
  @override
  void dispose() async {
    super.dispose();
    await vision.closeYoloModel();
  }
}