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
    print('이거는$spreadList');
    String tagsString = spreadList.join(', ');
    print(tagsString);
    return tagsString;
  }


}