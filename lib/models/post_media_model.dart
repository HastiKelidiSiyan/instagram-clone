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
    postId: json['post_id'].toString(),
    mediaUrl: json['media_url'].toString(),
    mediaType: json['media_type'].toString(),
    position: (json['position'] is int)
        ? json['position']
        : int.parse(json['position'].toString()),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'post_id': postId,
    'media_url': mediaUrl,
    'media_type': mediaType,
    'position': position,
  };
}
