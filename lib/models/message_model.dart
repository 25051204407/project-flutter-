class MessageModel {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
  });

  String get formattedTime {
    final h = timestamp.hour.toString().padLeft(2, '0');
    final m = timestamp.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String get preview => text.length > 30 ? '${text.substring(0, 30)}...' : text;
}
