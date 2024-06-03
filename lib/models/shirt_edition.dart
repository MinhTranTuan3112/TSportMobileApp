class ShirtEdition {
  int id;
  String code;
  String size;
  bool hasSignature;
  int price;
  String color;
  String status;
  String origin;
  String material;
  int seasonId;

  ShirtEdition(
      {required this.id,
      required this.code,
      required this.size,
      required this.hasSignature,
      required this.price,
      required this.color,
      required this.status,
      required this.origin,
      required this.material,
      required this.seasonId});

  factory ShirtEdition.fromJson(Map<String, dynamic> json) {
    return ShirtEdition(
      id: json['id'],
      code: json['code'],
      size: json['size'],
      hasSignature: json['hasSignature'],
      price: json['price'],
      color: json['color'],
      status: json['status'],
      origin: json['origin'],
      material: json['material'],
      seasonId: json['seasonId'],
    );
  }
}
