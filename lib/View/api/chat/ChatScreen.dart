import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Server/gpt/GPTRecipeServer.dart';
import 'package:recipt/Server/gpt/TodayWhatServer.dart';
import 'package:recipt/constans/colors.dart';

import '../../../main.dart';

class ChatMessage {
  final String user;
  final Widget message;

  ChatMessage(this.user, this.message);
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
  ChatScreen({required this.firstMessage,Key? key}) : super(key: key);
  final firstMessage;
}

class ChatScreenState extends State<ChatScreen> {
  final _messages = <ChatMessage>[];
  final _controller = TextEditingController();
  var tempMessage;
  String _user = 'User'; // Default user

  bool _isFirstMessageAdded = false;

  Future<bool> onBackKeyInChat(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xFFFFFFFF),
            title: Text(
              'GPT와의 채팅을 끝내시겠습니까?',
              style: TextStyle(color: mainText),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    //onWillpop에 true가 전달되어 앱이 종료 된다.
                    fetchGPTRefresh();
                    Get.offAll(MyApp());
                  },
                  child: Text('끝내기',style: TextStyle(color: SecondaryText),)),
              TextButton(
                  onPressed: () {
                    //onWillpop에 false 전달되어 앱이 종료되지 않는다.
                    Navigator.of(context).pop(false); // 대화 상자 닫기
                  },
                  child: Text('아니요',style: TextStyle(color: SecondaryText),)),
            ],
          );
        }) ?? false; // 취소 버튼이 눌릴 경우 false 반환
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFirstMessageAdded) {
      _messages.insert(0, ChatMessage('User', defaultText(widget.firstMessage,context)));
      _submitThenGPT(widget.firstMessage);
      _isFirstMessageAdded = true;
    }
    return WillPopScope(
      onWillPop: () => onBackKeyInChat(context),
      child: SafeArea(child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            fetchGPTRefresh();
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: mainText,
                          )
                      ),
                      SizedBox(width: 70,),
                      Text('오늘 뭐먹지?',style: Theme.of(context).textTheme.displayLarge,)
                    ]
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: _messages.length,
                itemBuilder: (_, index) {
                  final msg = _messages[index];
                  final bool isMe = msg.user == _user;

                  return Container(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: isMe ? Colors.blue[100] : Colors.grey[300],
                        ),
                        child: msg.message
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(hintText: 'GPT와 대화해보세요!'),
                      onSubmitted: (text) => _handleSubmit(_user, text),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () => _handleSubmit(_user, _controller.text),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ))
    );
  }

  void _handleSubmit(String user, String message) {
    _controller.clear();
    setState(() {
      _messages.insert(0, ChatMessage('User', defaultText(message,context)));
    });

    _submitThenGPT(message);
  }

  void _submitThenGPT(message) async {
    setState(() {
      _messages.insert(0, ChatMessage('System', Column(
        children: [
          defaultText('GPT가 입력중입니다. \n잠시만 기다려주세요!',context),
          SizedBox(height: 15,),
          Container(
              width: 150,
              height: 80,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/icons/voice2.gif"),
                radius: 40.0,
              )
          )
        ],
      )));
    });
    String tempMess = await fetchChat(message);
    print(tempMess);
    setState(() {
      _messages.removeAt(0);
      _messages.insert(0, ChatMessage('System', defaultText(tempMess,context)));
    });
  }
}

Widget defaultText(data,context){
  return Text(data,style: Theme.of(context).textTheme.displayMedium);
}