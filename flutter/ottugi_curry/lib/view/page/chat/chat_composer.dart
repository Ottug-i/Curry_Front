import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/chat/chat_controller.dart';
import 'package:ottugi_curry/model/message_model.dart';

class buildChatComposer extends StatelessWidget {
  final ScrollController scrollController; // Add this line

  const buildChatComposer({required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatContorller = Get.find<ChatController>();
    TextEditingController textController = TextEditingController();

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        height: 100,
        child: Row(
          // 하단 메세지 입력창 부분
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  height: 60,
                  // margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    // 메세지 입력창
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      // 음성 입력 버튼
                      Icon(Icons.mic, color: Colors.grey[500]),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type your message ...',
                              hintStyle: TextStyle(color: Colors.grey[500])),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 16,
            ),
            /*CircleAvatar(
              backgroundColor: lightColorScheme.primary,
              child: const Icon(Icons.send, color: Colors.white),
            ),*/
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                String question = textController.text.trim();
                chatContorller.addToChat(question, Message.SENT_BY_ME);
                textController.clear();
                chatContorller.callAPI(question);
              },
            ),
          ],
        ));
  }
}
