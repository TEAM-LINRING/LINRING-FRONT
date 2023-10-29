class User {
  final int? id;
  final String? lastLogin;
  final String? created;
  final String? modified;
  final String? name;
  final String? email;
  final String? nickname;
  final String? profile;
  final String? department;
  final int? studentNumber;
  final String? gender;
  final int? birth;
  final String? rating;
  final bool? isActive;
  final List<int>? groups;
  final List<int>? userPermissions;
  final List<int>? significant;

  User({
    this.id,
    this.lastLogin,
    this.created,
    this.modified,
    this.name,
    this.email,
    this.nickname,
    this.profile,
    this.department,
    this.studentNumber,
    this.gender,
    this.birth,
    this.rating,
    this.isActive,
    this.groups,
    this.userPermissions,
    this.significant,
  });

  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      lastLogin: json['last_login'],
      created: json['created'],
      modified: json['modified'],
      name: json['name'],
      email: json['email'],
      nickname: json['nickname'],
      profile: json['profile'],
      department: json['department'],
      studentNumber: json['student_number'],
      gender: json['gender'],
      birth: json['birth'],
      rating: json['rating'],
      isActive: json['is_active'],
      groups: List<int>.from(json['groups']),
      userPermissions: List<int>.from(json['user_permissions']),
      significant: List<int>.from(json['significant']),
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "id": id,
      "last_login": lastLogin,
      "created": created,
      "modified": modified,
      "name": name,
      "email": email,
      "nickname": nickname,
      "profile": profile,
      "department": department,
      "student_number": studentNumber,
      "gender": gender,
      "birth": birth,
      "rating": rating,
      "is_active": isActive,
      "groups": groups,
      "user_permissions": userPermissions,
      "significant": significant,
    };
  }
}
