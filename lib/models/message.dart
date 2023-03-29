class Message {
  String text;
  DateTime date;
  bool isSentByMe;

  Message({
    required this.text,
    required this.isSentByMe,
    required this.date,
  });
}
