class Comment {
  final String id;
  final DateTime timestamp;
  final String username;
  final String text;
  final int likeCount;

  Comment({
    required this.id,
    required this.timestamp,
    required this.username,
    required this.text,
    required this.likeCount,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      timestamp: DateTime.parse(json['timestamp']),
      username: json['username'],
      text: json['text'],
      likeCount: json['like_count'],
    );
  }
}
