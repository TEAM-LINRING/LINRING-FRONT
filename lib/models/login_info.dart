import 'package:linring_front_flutter/models/user_model.dart';

class LoginInfo {
  final String access;
  final String refresh;
  final User user;

  LoginInfo({
    required this.access,
    required this.refresh,
    required this.user,
  });

  factory LoginInfo.fromJson(Map<dynamic, dynamic> json) {
    return LoginInfo(
      access: json['access'] as String,
      refresh: json['refresh'] as String,
      user: User.fromJson(json['user']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "access": access,
      "refresh": refresh,
      "user": user.toJson(),
    };
  }
}
