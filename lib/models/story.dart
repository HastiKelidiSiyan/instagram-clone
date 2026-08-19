import 'user.dart';

class Story {
  final bool seen;
  final User user;

  Story({required this.seen, required this.user});

  factory Story.fromJson(Map<String, dynamic> json) =>
      Story(seen: json['seen'], user: User.fromJson(json['user']));

  Map<String, dynamic> toJson() => {'seen': seen, 'user': user.toJson()};
}
