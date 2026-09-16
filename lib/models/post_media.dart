class PostMedia {

  final int id;
  final int postId;
  final String mediaUrl;
  final String mediaType;
  final int position;

  PostMedia({
    required this.id,
    required this.postId,
    required this.mediaUrl,
    required this.mediaType,
    required this.position,
  });
}