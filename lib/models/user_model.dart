import 'dart:ffi';

class User {
  final int id;
  final DateTime? lastLogin;
  final DateTime created;
  final DateTime modified;
  final String username;
  final String email;
  final String nickname;
  final String? profile;
  final String department;
  final int? studentNumber;
  final String gender;
  final String? significant;
  final String? rating;
  final bool isActive;
  final Array groups;
  final Array userPermissions;

  User({
    required this.id,
    required this.lastLogin,
    required this.created,
    required this.modified,
    required this.username,
    required this.email,
    required this.nickname,
    required this.profile,
    required this.department,
    required this.studentNumber,
    required this.gender,
    required this.significant,
    required this.rating,
    required this.isActive,
    required this.groups,
    required this.userPermissions,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      lastLogin: DateTime.parse(json["last_login"]),
      created: DateTime.parse(json["created"]),
      modified: DateTime.parse(json["modified"]),
      username: json["username"],
      email: json["email"],
      nickname: json["nickname"],
      profile: json["profile"],
      department: json["department"],
      studentNumber: json["student_number"],
      gender: json["gender"],
      significant: json["significant"],
      rating: json["rating"],
      isActive: json["is_active"],
      groups: json["groups"],
      userPermissions: json["user_permissions"],
    );
  }
}
