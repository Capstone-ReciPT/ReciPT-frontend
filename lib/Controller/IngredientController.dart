import 'package:get/get.dart';

class IngreController extends GetxController{

  var ingreList = [].obs;

  listClear(){
    ingreList.clear();
    update();
  }

  listAdd(val){
    ingreList.add(val);
    update();
  }

  listPush(){
    var spreadList = [...ingreList];
    String tagsString = spreadList.join(', ');
    return tagsString;
  }


}