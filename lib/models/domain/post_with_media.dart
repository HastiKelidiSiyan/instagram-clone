import '../post_media_model.dart';
import '../post_model.dart';

class PostWithMedia {
  final PostModel post;
  final List<PostMediaModel> media;

  const PostWithMedia({
    required this.post,
    required this.media,
  });

  factory PostWithMedia.fromJson(Map<String, dynamic> json) {
    final postJson = json['post'] == null
        ? json
        : Map<String, dynamic>.from(json['post']);
    final mediaJson = json['media'] as List<dynamic>? ?? [];

    return PostWithMedia(
      post: PostModel.fromJson(postJson),
      media: mediaJson
          .map(
            (item) => PostMediaModel.fromJson(
              Map<String, dynamic>.from(item),
            ),
          )
          .toList(),
    );
  }
}
