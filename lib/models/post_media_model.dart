class PostMediaModel {
  final String id;
  final String postId;
  final String mediaUrl;
  final String mediaType;
  final int position;

  PostMediaModel({
    required this.id,
    required this.postId,
    required this.mediaUrl,
    required this.mediaType,
    required this.position,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) => PostMediaModel(
    id: json['id'].toString(),
    postId: json['postId'] ?? json['post_id'],
    mediaUrl: json['mediaUrl'] ?? json['media_url'],
    mediaType: json['mediaType'] ?? json['media_type'],
    position: (json['position'] is int)
        ? json['position']
        : int.parse(json['position'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'postId': postId,
    'mediaUrl': mediaUrl,
    'mediaType': mediaType,
    'position': position,
  };
}
