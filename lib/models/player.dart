class Player {
  int id;
  String code;
  String name;
  String status;
  int clubId;

  Player(
      {required this.id,
      required this.code,
      required this.name,
      required this.status,
      required this.clubId});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      status: json['status'],
      clubId: json['clubId'],
    );
  }
}
