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
        userId: json['user_id'].toString(),
        storyId: json['story_id'].toString(),
        viewedAt: DateTime.parse(json['viewed_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'story_id': storyId,
        'viewed_at': viewedAt.toIso8601String(),
      };
}
