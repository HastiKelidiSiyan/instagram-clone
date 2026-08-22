import 'user_model.dart';

class StoryModel {
  final bool seen;
  final UserModel user;

  StoryModel({required this.seen, required this.user});

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      StoryModel(seen: json['seen'], user: UserModel.fromJson(json['user']));

  Map<String, dynamic> toJson() => {'seen': seen, 'user': user.toJson()};
}
