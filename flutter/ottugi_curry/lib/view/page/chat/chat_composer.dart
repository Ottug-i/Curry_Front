import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/chat/chat_controller.dart';
import 'package:ottugi_curry/model/message_model.dart';

class ChatComposer extends StatefulWidget {
  final ScrollController pageScroller;
  const ChatComposer({required this.pageScroller, Key? key}) : super(key: key);

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

final chatContorller = Get.find<ChatController>();
TextEditingController textController = TextEditingController();

class _ChatComposerState extends State<ChatComposer> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white.withOpacity(0.7),
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
                          onSubmitted: (value) => submitAction(
                              textController, chatContorller, widget),
                        ),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              width: 16,
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                submitAction(textController, chatContorller, widget);

                /*widget.pageScroller.scrollController.animateTo(
                    // 가장 최근 것 말고 그 전 것으로 올라감..!
                    widget
                        .pageScroller.scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.ease);*/
              },
            ),
          ],
        ));
  }
}

void submitAction(textController, chatContorller, widget) {
  String question = textController.text.trim();
  chatContorller.addToChat(question, Message.SENT_BY_ME);
  textController.clear();
  chatContorller.callAPI(question);

  SchedulerBinding.instance.addPostFrameCallback((_) {
    widget.pageScroller.animateTo(
      widget.pageScroller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  });
}
