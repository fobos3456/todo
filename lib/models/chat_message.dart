enum MessageSender { user, tutor }

class ChatMessage {
  final String id;
  final MessageSender sender;
  final String text;
  final DateTime timestamp;
  final List<String> suggestedActions;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    DateTime? timestamp,
    this.suggestedActions = const [],
  }) : timestamp = timestamp ?? DateTime.now();
}
