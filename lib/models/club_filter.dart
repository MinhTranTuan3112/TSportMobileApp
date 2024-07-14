class ClubFilter {
  final int id;
  final String name;

  ClubFilter({required this.id, required this.name});

  factory ClubFilter.fromJson(Map<String, dynamic> json) {
    return ClubFilter(
      id: json['id'],
      name: json['name'],
    );
  }
}