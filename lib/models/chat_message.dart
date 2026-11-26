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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender.name,
      'text': text,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'suggestedActions': suggestedActions,
    };
  }

  factory ChatMessage.fromMap(Map<String, dynamic> map, String docId) {
    return ChatMessage(
      id: docId.isNotEmpty ? docId : (map['id'] ?? ''),
      sender: map['sender'] == 'user' ? MessageSender.user : MessageSender.tutor,
      text: map['text'] ?? '',
      timestamp: map['timestamp'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timestamp'])
          : DateTime.now(),
      suggestedActions: List<String>.from(map['suggestedActions'] ?? []),
    );
  }
}
