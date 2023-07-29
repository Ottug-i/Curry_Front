import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:get/get.dart';
import 'package:ottugi_curry/view/controller/chat/chat_controller.dart';
import 'package:ottugi_curry/model/message_model.dart';

class Conversation extends StatelessWidget {
  final ScrollController scrollController; // Add this line

  const Conversation({required this.scrollController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chatContorller = Get.find<ChatController>();

    return Obx(
      () => ListView.builder(
        // 메세지 말풍선
        // reverse: true, // messages[0]이 아래에서부터 뜨도록 (message[0]이 가장 최신 메세지)
        controller: scrollController,
        itemCount: chatContorller.messageList.length,
        itemBuilder: (context, int index) {
          final message = chatContorller.messageList[index];
          // bool message.SENT_BY_ME = message.sender!.id == currentUser.id; // 메세지 송신자가 나인지 상대방인지 구분하는 변수
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: message.sentBy == Message.SENT_BY_ME
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        // 말풍선
                        padding: const EdgeInsets.all(8),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width *
                                0.6), // 즉 말풍선의 가로 길이. 얼만큼 차지할 것인지
                        decoration: BoxDecoration(
                            color: message.sentBy == Message.SENT_BY_ME
                                ? lightColorScheme.primary
                                : customColorScheme.chatgptColor,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(
                                    message.sentBy == Message.SENT_BY_ME
                                        ? 12
                                        : 0),
                                bottomRight: Radius.circular(
                                    message.sentBy == Message.SENT_BY_ME
                                        ? 0
                                        : 12))),
                        child: Text(
                          message.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: message.sentBy == Message.SENT_BY_ME
                                      ? Colors.grey[800]
                                      : Colors.white),
                        )),
                  ],
                ),
                /*
                    Padding( // 메세지 밑에 뜨는 부분 (읽음 확인 아이콘과 시간)
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment:
                            message.SENT_BY_ME ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Icon(Icons.done_all,
                              size: 20, color: lightColorScheme.onSurfaceVariant),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            message.time!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )*/
              ],
            ),
          );
        },
      ),
    );
  }
}
