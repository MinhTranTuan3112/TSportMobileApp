class Season {
  int id;
  String code;
  String name;
  int clubId;

  Season(
      {required this.id,
      required this.code,
      required this.name,
      required this.clubId});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      clubId: json['clubId'],
    );
  }
}
