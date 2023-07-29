import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';
import 'package:ottugi_curry/view/page/chat/message_model.dart';
import 'package:ottugi_curry/view/page/chat/user_model.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        // 메세지 말풍선
        reverse: true, // messages[0]이 아래에서부터 뜨도록 (message[0]이 가장 최신 메세지)
        itemCount: messages.length,
        itemBuilder: (context, int index) {
          final message = messages[index];
          bool isMe = message.sender!.id ==
              currentUser.id; // 메세지 송신자가 나인지 상대방인지 구분하는 변수
          return Container(
            margin: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        // 말풍선
                        padding: const EdgeInsets.all(8),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width *
                                0.6), // 즉 말풍선의 가로 길이. 얼만큼 차지할 것인지
                        decoration: BoxDecoration(
                            color: isMe
                                ? lightColorScheme.primary
                                : customColorScheme.chatgptColor,
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isMe ? 12 : 0),
                                bottomRight: Radius.circular(isMe ? 0 : 12))),
                        child: Text(
                          message.text!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color:
                                      isMe ? Colors.grey[800] : Colors.white),
                        )),
                  ],
                ),
                /*
                Padding( // 메세지 밑에 뜨는 부분 (읽음 확인 아이콘과 시간)
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
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
        });
  }
}
