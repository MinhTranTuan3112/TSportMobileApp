class OrderInCart {
  int id;
  String? code;
  DateTime orderDate;
  String status;
  int total;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;
  List<OrderDetail> orderDetails;

  OrderInCart({
    required this.id,
    this.code,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
    required this.orderDetails,
  });

  factory OrderInCart.fromJson(Map<String, dynamic> json) => OrderInCart(
        id: json['id'],
        code: json['code'],
        orderDate: DateTime.parse(json['order-date']),
        status: json['status'],
        total: json['total'],
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] == null
            ? DateTime.now()
            : DateTime.parse(json['modified-date']),
        modifiedAccountId: json['modified-account-id'] ?? 0,
        orderDetails: List<OrderDetail>.from(
            json['order-details'].map((x) => OrderDetail.fromJson(x))),
      );
}

class OrderDetail {
  int orderId;
  int shirtId;
  String? code;
  String size;
  double subtotal;
  int quantity;
  String status;
  Shirt shirt;

  OrderDetail({
    required this.orderId,
    required this.shirtId,
    this.code,
    required this.size,
    required this.subtotal,
    required this.quantity,
    required this.status,
    required this.shirt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderId: json['order-id'],
        shirtId: json['shirt-id'],
        code: json['code'],
        size: json['size'],
        subtotal: (json['subtotal'] as num).toDouble(),
        quantity: json['quantity'],
        status: json['status'],
        shirt: Shirt.fromJson(json['shirt']),
      );
}

class Shirt {
  int id;
  String code;
  String name;
  String? description;
  int? quantity;
  String status;
  int shirtEditionId;
  int seasonPlayerId;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;
  List<ShirtImage> images;
  ShirtEdition shirtEdition;

  Shirt({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    this.quantity,
    required this.status,
    required this.shirtEditionId,
    required this.seasonPlayerId,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
    required this.images,
    required this.shirtEdition,
  });

  factory Shirt.fromJson(Map<String, dynamic> json) => Shirt(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        quantity: json['quantity'] ?? 0,
        status: json['status'],
        shirtEditionId: json['shirt-edition-id'],
        seasonPlayerId: json['season-player-id'],
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] != null
            ? DateTime.parse(json['modified-date'])
            : null,
        modifiedAccountId: json['modified-account-id'] ?? 0,
        images: List<ShirtImage>.from(
            json['images'].map((x) => ShirtImage.fromJson(x))),
        shirtEdition: ShirtEdition.fromJson(json['shirt-edition']),
      );
}

class ShirtImage {
  int id;
  String? url;
  int shirtId;

  ShirtImage({
    required this.id,
    this.url,
    required this.shirtId,
  });

  factory ShirtImage.fromJson(Map<String, dynamic> json) => ShirtImage(
        id: json['id'],
        url: json['url'],
        shirtId: json['shirt-id'],
      );
}

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
      modifiedDate: json['modified-date'] != null
          ? DateTime.parse(json['modified-date'])
          : null, // Handling nullable DateTime
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
