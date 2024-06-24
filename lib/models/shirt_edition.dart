class ShirtEdition {
  final int id;
  final String code;
  final String size;
  final bool? hasSignature;
  final double stockPrice;
  final double? discountPrice;
  final String? color;
  final String? status;
  final String? origin;
  final int quantity;
  final String? material;
  final int seasonId;
  final DateTime createdDate;
  final int createdAccountId;
  final DateTime? modifiedDate;
  final int? modifiedAccountId;

  ShirtEdition({
    required this.id,
    required this.code,
    required this.size,
    this.hasSignature,
    required this.stockPrice,
    this.discountPrice,
    this.color,
    this.status,
    this.origin,
    required this.quantity,
    this.material,
    required this.seasonId,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
  });

  factory ShirtEdition.fromJson(Map<String, dynamic> json) {
    return ShirtEdition(
      id: json['id'],
      code: json['code'],
      size: json['size'],
      hasSignature: json['has-signature'],
      stockPrice: json['stock-price'],
      discountPrice: json['discount-price'],
      color: json['color'],
      status: json['status'],
      origin: json['origin'],
      quantity: json['quantity'],
      material: json['material'],
      seasonId: json['season-id'],
      createdDate: DateTime.parse(json['created-date']),
      createdAccountId: json['created-account-id'],
      modifiedDate: json['modified-date'] != null ? DateTime.parse(json['modified-date']) : null, // Handling nullable DateTime
      modifiedAccountId: json['modified-account-id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'size': size,
      'has-signature': hasSignature,
      'stock-price': stockPrice,
      'discount-price': discountPrice,
      'color': color,
      'status': status,
      'origin': origin,
      'quantity': quantity,
      'material': material,
      'season-id': seasonId,
      'created-date': createdDate.toIso8601String(),
      'created-account-id': createdAccountId,
      'modified-date': modifiedDate?.toIso8601String(),
      'modified-account-id': modifiedAccountId,
    };
  }
}