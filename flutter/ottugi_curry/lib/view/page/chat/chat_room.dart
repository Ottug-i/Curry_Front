import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/page/chat/chat_composer.dart';
import 'package:ottugi_curry/view/page/chat/conversation.dart';
import 'package:ottugi_curry/view/page/chat/user_model.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key, required this.user});

  @override
  State<ChatRoom> createState() => _ChatRoomState();

  final User user;
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.primary,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 입력창 바깥(배경)을 터치하면 키보드 사라지도록
        },
        child: Column(children: [
          // 채팅 흰 배경 부분
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Conversation(user: widget.user),
              ),
            ),
          ),
          const buildChatComposer()
        ]),
      ),
    );
  }
}
