class PostMediaModel {

  final int id;
  final int postId;
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
        id: json['id'],
        postId: json['postId'],
        mediaUrl: json['mediaUrl'],
        mediaType: json['mediaType'],
        position: json['position'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'postId': postId,
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
        'position': position,
      };
}