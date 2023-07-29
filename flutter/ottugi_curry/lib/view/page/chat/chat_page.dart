import 'package:flutter/cupertino.dart';
import 'package:ottugi_curry/view/page/chat/chat_room.dart';
import 'package:ottugi_curry/view/page/chat/message_model.dart';

// 화면 테스트용 Page 파일
// 필요한 곳에 ChatRoom(user: recentChat.sender!) 바로 넣어야 함
class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final recentChat = recentChats[1];

  @override
  Widget build(BuildContext context) {
    return ChatRoom(user: recentChat.sender!);
  }
}
