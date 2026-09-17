class StoryViewModel {
  final String userId;
  final String storyId;
  final DateTime viewedAt;

  StoryViewModel({
    required this.userId,
    required this.storyId,
    required this.viewedAt,
  });

  factory StoryViewModel.fromJson(Map<String, dynamic> json) => StoryViewModel(
        userId: json['userId'],
        storyId: json['storyId'],
        viewedAt: DateTime.parse(json['viewedAt']),
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'storyId': storyId,
        'viewedAt': viewedAt.toIso8601String(),
      };
}