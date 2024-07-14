class SeasonFilter {
  final int id;
  final String name;

  SeasonFilter({required this.id, required this.name});

  factory SeasonFilter.fromJson(Map<String, dynamic> json) {
    return SeasonFilter(
      id: json['id'],
      name: json['name'],
    );
  }
}