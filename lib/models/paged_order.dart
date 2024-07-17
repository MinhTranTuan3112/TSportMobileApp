class PagedOrder {
  int id;
  String? code;
  DateTime orderDate;
  String status;
  double total;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;

  PagedOrder({
    required this.id,
    this.code,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
  });

  factory PagedOrder.fromJson(Map<String, dynamic> json) => PagedOrder(
        id: json['id'],
        code: json['code'],
        orderDate: DateTime.parse(json['order-date']),
        status: json['status'],
        total: json['total'].toDouble(),
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] != null
            ? DateTime.parse(json['modified-date'])
            : null,
        modifiedAccountId: json['modified-account-id'] != null
            ? int.parse(json['modified-account-id'])
            : null,
      );
}
