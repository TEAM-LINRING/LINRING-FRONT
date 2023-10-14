class tagset {
  final int id;
  final DateTime created;
  final DateTime modified;
  final String place;
  final bool isSameDepartment;
  final String person;
  final String method;
  final bool isActive;
  final String? introduction;
  final int owner;

  tagset({
    required this.id,
    required this.created,
    required this.modified,
    required this.place,
    required this.isSameDepartment,
    required this.person,
    required this.method,
    required this.isActive,
    required this.introduction,
    required this.owner,
  });

  factory tagset.fromJson(Map<String, dynamic> json) {
    return tagset(
      id: json["id"],
      created: DateTime.parse(json["created"]),
      modified: DateTime.parse(json["modified"]),
      place: json["place"],
      isSameDepartment: json["isSameDepartment"],
      person: json["person"],
      method: json["method"],
      isActive: json["is_active"],
      introduction: json["introduction"],
      owner: json["owner"],
    );
  }
}
