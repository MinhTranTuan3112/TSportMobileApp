class PagedResult<T> {
  int totalCount;
  int pageNumber;
  int pageSize;
  List<T> items;

  PagedResult(
      {required this.totalCount,
      required this.pageNumber,
      required this.pageSize,
      required this.items});

  factory PagedResult.fromJson(Map<String, dynamic> json, Function fromJson) {
    return PagedResult(
      totalCount: json['totalCount'],
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      items: json['items'].map<T>((item) => fromJson(item)).toList(),
    );
  }
}

