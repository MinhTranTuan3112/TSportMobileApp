class PagedResult<T> {
  int totalCount;
  int pageNumber;
  int pageSize;
  int totalPages;
  List<T> items;

  PagedResult(
      {required this.totalCount,
      required this.pageNumber,
      required this.pageSize,
      required this.totalPages,
      required this.items});

  factory PagedResult.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    return PagedResult(
      totalCount: json['total-count'] as int? ?? 0,
      pageNumber: json['page-number'] as int? ?? 0,
      pageSize: json['page-size'] as int? ?? 0,
      totalPages: json['total-pages'] as int? ?? 0,
      items: (json['items'] as List<dynamic>)
          .map<T>((item) => fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
