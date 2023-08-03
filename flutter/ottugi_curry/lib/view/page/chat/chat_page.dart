import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ottugi_curry/view/controller/chat/page_scroll_controller.dart';
import 'package:ottugi_curry/view/page/chat/chat_composer.dart';
import 'package:ottugi_curry/view/page/chat/conversation.dart';
import 'package:ottugi_curry/view/controller/chat/chat_controller.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatContorller = Get.put(ChatController());
  final pageController = Get.put(PageScrollController());

  @override
  void dispose() {
    Get.delete<ChatController>();
    Get.delete<PageScrollController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // 뒤로가기 동작
          },
        ),
      ),*/
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Stack(children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // 입력창 바깥(배경)을 터치하면 키보드 사라지도록
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment
                  .start, // 앱바를 사용하지 않고 아이콘 버튼으만을 사용해서 뒤로가기를 해서, 왼쪽 배치 필요.
              children: [
                IconButton(
                  padding: const EdgeInsets.only(top: 30),
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context); // 뒤로가기 동작
                  },
                ),
                // 채팅 흰 배경 부분
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                        //color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      child: Conversation(pageScroller: pageController),
                    ),
                  ),
                ),
                // 메세지 입력창
                ChatComposer(pageScroller: pageController),
              ]),
        ),
        Obx(() => Offstage(
            offstage: !chatContorller.isLoading.value, // isLoading이 false면 감춰~
            child: const Stack(children: <Widget>[
              //다시 stack
              Opacity(
                //뿌옇게~
                opacity: 0.5,
                child: ModalBarrier(
                    dismissible: false, color: Colors.black), //클릭 못하게
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ])))
      ]),
    );
  }
}
