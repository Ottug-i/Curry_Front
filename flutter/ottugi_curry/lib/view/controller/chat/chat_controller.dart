import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ottugi_curry/model/message_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatController extends GetxController {
  RxList<Message> messageList = <Message>[].obs;

  String api_key = dotenv.get("chatgptKey");

  void addToChat(String message, String sentBy) {
    messageList.add(Message(message, sentBy));
  }

  void addResponse(String response) {
    messageList.removeAt(messageList.length - 1);
    messageList.add(Message(response, Message.SENT_BY_BOT));
  }

  void callAPI(String question) async {
    addToChat("Typing...", Message.SENT_BY_BOT);

    Map<String, dynamic> baseAi = {
      "role": "user",
      "content": "You are a helpful and kind AI Assistant.",
    };

    Map<String, dynamic> userMsg = {
      "role": "user",
      "content": question,
    };

    List<Map<String, dynamic>> messages = [baseAi, userMsg];

    Map<String, dynamic> requestBody = {
      "model": "gpt-3.5-turbo",
      "messages": messages,
    };

    final response = await http.post(
      Uri.parse("https://api.openai.com/v1/chat/completions"),
      headers: {
        "Authorization": "Bearer $api_key",
        "Content-Type": "application/json",
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(utf8.decode(response.bodyBytes));
      var result = responseBody["choices"][0]["message"]["content"];
      addResponse(result.trim());
    } else {
      addResponse("Failed to load response due to ${response.body}");
    }
  }
}
