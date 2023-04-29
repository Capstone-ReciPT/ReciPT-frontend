import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(top: 10),
                  width: 800,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: Colors.black87,
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueGrey,
                          child: Icon(Icons.person,color: Colors.white,size: 80,),
                        ),
                      ),
                      SizedBox(width: 50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('손지석',style: TextStyle(color: Colors.white,fontSize: 30),),
                          Text('팔로워 0, 팔로잉 0',style: TextStyle(color: Colors.white),),
                          SizedBox(height: 8,),
                          TextButton(onPressed: (){},
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(width: 1,color: Colors.greenAccent),
                                  ),
                                ),
                              ),
                              child: Text('레시피 등록',style: TextStyle(color: Colors.greenAccent),)
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Notice(),
              ],
            )
        )
    );
  }
}
// Container(

//
//


class Notice extends StatelessWidget {

  const Notice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: (){},
              child: Text('내 레시피')
          ),
          TextButton(onPressed: (){},
              child: Text('내 레시피')
          ),
          TextButton(onPressed: (){},
              child: Text('내 레시피')
          ),
        ],
      ),
    );
  }
}

