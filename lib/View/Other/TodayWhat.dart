import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipt/Widget/Custom_Text_Form_field.dart';

class TodayWhat extends StatefulWidget {
  TodayWhat({Key? key}) : super(key: key);

  var _userCommandInput;
  @override
  State<TodayWhat> createState() => _TodayWhatState();
}

class _TodayWhatState extends State<TodayWhat> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('요청 사항들을 무엇이든 적어주세요!',style: Theme.of(context).textTheme.displayLarge,),
          SizedBox(height: 50,),
          CustomTextFormField(
            onChanged:(value) {
              setState(() {
                widget._userCommandInput = value;
              });
            },
            onEditingComplete: () {
              Get.to(ChatScreen());
            },
            hint: 'ex) 맵지 않고 달달한 음식',
            prefixIcon: Icons.edit_note_sharp,
          ),
        ],
      ),
    ));
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatMessage {
  final String user;
  final String message;

  ChatMessage(this.user, this.message);
}

class ChatScreenState extends State<ChatScreen> {
  final _messages = <ChatMessage>[];
  final _controller = TextEditingController();
  String _user = 'User'; // Default user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Screen')),
      body: Column(
        children: [
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
                      color: isMe ? Colors.blueAccent[100] : Colors.grey[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(msg.message,style: Theme.of(context).textTheme.displayMedium),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: 'Enter a message'),
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
        ],
      ),
    );
  }

  void _handleSubmit(String user, String message) {
    _controller.clear();
    setState(() {
      _messages.insert(0, ChatMessage(user, message));
    });
  }
}