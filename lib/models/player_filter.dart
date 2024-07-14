class PlayerFilter {
  final int id;
  final String name;

  PlayerFilter({required this.id, required this.name});

  factory PlayerFilter.fromJson(Map<String, dynamic> json) {
    return PlayerFilter(
      id: json['id'],
      name: json['name'],
    );
  }
}