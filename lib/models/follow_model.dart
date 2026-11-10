class FollowModel {
  final String followerId;
  final String followingId;
  final DateTime createdAt;

  FollowModel({
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        followerId: json['follower_id'].toString(),
        followingId: json['following_id'].toString(),
        createdAt: DateTime.parse(json['created_at'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'follower_id': followerId,
        'following_id': followingId,
        'created_at': createdAt.toIso8601String(),
      };
}
