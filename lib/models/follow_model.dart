class FollowModel{

  final String followerId;
  final String followingId;
  final DateTime createdAt;

  FollowModel({
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        followerId: json['followerId'],
        followingId: json['followingId'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'followerId': followerId,
        'followingId': followingId,
        'createdAt': createdAt.toIso8601String(),
      };
}