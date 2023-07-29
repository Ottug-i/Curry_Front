class Message {
  static const String SENT_BY_ME = "SENT_BY_ME";
  static const String SENT_BY_BOT = "SENT_BY_BOT";

  final String content;
  final String sentBy;

  Message(this.content, this.sentBy);
}
