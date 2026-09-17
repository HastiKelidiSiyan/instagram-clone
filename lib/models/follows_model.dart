class FollowsModel{

  final int follwerId;
  final int followingId;
  final DateTime createdAt;

  FollowsModel({
    required this.follwerId,
    required this.followingId,
    required this.createdAt,
  });

  factory FollowsModel.fromJson(Map<String, dynamic> json) => FollowsModel(
        follwerId: json['followerId'],
        followingId: json['followingId'],
        createdAt: DateTime.parse(json['createdAt']),
      );

  Map<String, dynamic> toJson() => {
        'followerId': follwerId,
        'followingId': followingId,
        'createdAt': createdAt.toIso8601String(),
      };
}