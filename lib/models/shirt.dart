import 'package:tsport_mobile_app/models/shirt_edition.dart';

class ShirtItem {
  int id;
  String code;
  String name;
  String? description;
  int? quantity;
  String? status;
  int shirtEditionId;
  int seasonPlayerId;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;
  List<ShirtImage> images;
  ShirtEdition shirtEdition;

  ShirtItem({
    required this.id,
    required this.code,
    required this.name,
    this.description,
    this.quantity,
    this.status,
    required this.shirtEditionId,
    required this.seasonPlayerId,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
    required this.images,
    required this.shirtEdition,
  });

  factory ShirtItem.fromJson(Map<String, dynamic> json) => ShirtItem(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'] ?? '',
        quantity: json['quantity'] ?? 0,
        status: json['status'] ?? 0,
        shirtEditionId: json['shirt-edition-id'],
        seasonPlayerId: json['season-player-id'],
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] != null ? DateTime.parse(json['modified-date']) : null,
        modifiedAccountId: json['modified-account-id'],
        images: List<ShirtImage>.from(
            json['images'].map((x) => ShirtImage.fromJson(x))),
        shirtEdition: ShirtEdition.fromJson(json['shirt-edition']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'name': name,
        'description': description,
        'quantity': quantity,
        'status': status,
        'shirt-edition-id': shirtEditionId,
        'season-player-id': seasonPlayerId,
        'created-date': createdDate.toIso8601String(),
        'created-account-id': createdAccountId,
        'modified-date': modifiedDate?.toIso8601String(),
        'modified-account-id': modifiedAccountId,
        'images': List<dynamic>.from(images.map((x) => x.toJson())),
        'shirt-edition': shirtEdition.toJson(),
      };
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'shirt-id': shirtId,
      };
}

