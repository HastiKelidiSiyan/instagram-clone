class AuthModel {
  final String accessToken;
  final String refreshToken;
  final int expiresIn;
  final String userId;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.userId,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'],
      userId: json['user']['id'],
    );
  }
}