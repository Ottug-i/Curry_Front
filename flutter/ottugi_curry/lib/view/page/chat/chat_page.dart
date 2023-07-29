import 'package:flutter/cupertino.dart';
import 'package:ottugi_curry/view/page/chat/chat_room.dart';

// 화면 테스트용 Page 파일
// 필요한 곳에 ChatRoom(user: recentChat.sender!) 바로 넣어야 함
class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ChatRoom();
  }
}
