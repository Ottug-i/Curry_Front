import 'package:flutter/material.dart';
import 'package:ottugi_curry/config/color_schemes.dart';

class buildChatComposer extends StatelessWidget {
  const buildChatComposer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            // 우측 음성 입력 버튼
            CircleAvatar(
              backgroundColor: lightColorScheme.primary,
              child: const Icon(Icons.send, color: Colors.white),
            )
          ],
        ));
  }
}
