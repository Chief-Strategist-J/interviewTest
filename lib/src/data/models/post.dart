class Post {
  final String title;
  final String body;
  final bool isRead;
  final int timerDuration;
  final int elapsedTime;
  final bool isVisible;

  const Post({
    required this.title,
    required this.body,
    this.isRead = false,
    this.timerDuration = 0,
    this.elapsedTime = 0,
    this.isVisible = true,
  });

  Post copyWith({
    String? title,
    String? body,
    bool? isRead,
    int? timerDuration,
    int? elapsedTime,
    bool? isVisible,
  }) {
    return Post(
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
      timerDuration: timerDuration ?? this.timerDuration,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      isVisible: isVisible ?? this.isVisible,
    );
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      body: json['body'],
      isRead: false,
      timerDuration: 10,
      elapsedTime: 0,
      isVisible: true,
    );
  }
}