class ShirtDetails {
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
  Account createdAccount;
  List<ShirtImage> images;
  Account? modifiedAccount;
  List<OrderDetail> orderDetails;
  SeasonPlayer? seasonPlayer;
  ShirtEdition? shirtEdition;

  ShirtDetails({
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
    required this.createdAccount,
    required this.images,
    this.modifiedAccount,
    required this.orderDetails,
    this.seasonPlayer,
    this.shirtEdition,
  });

  factory ShirtDetails.fromJson(Map<String, dynamic> json) => ShirtDetails(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'] ?? '',
        quantity: json['quantity'] ?? 0,
        status: json['status'],
        shirtEditionId: json['shirt-edition-id'],
        seasonPlayerId: json['season-player-id'],
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] != null
            ? DateTime.parse(json['modified-date'])
            : null,
        modifiedAccountId: json['modified-account-id'] != null ? int.parse(json['modified-account-id']) : null,
        createdAccount: Account.fromJson(json['created-account']),
        images: List<ShirtImage>.from(
            json['images'].map((x) => ShirtImage.fromJson(x))),
        modifiedAccount: json['modified-account'] != null
            ? Account.fromJson(json['modified-account'])
            : null,
        orderDetails: json['order-details'] != null && json['order-details'] != [] ? List<OrderDetail>.from(
            json['order-details'].map((x) => OrderDetail.fromJson(x))) : [],
        seasonPlayer: json['season-player'] != null
            ? SeasonPlayer.fromJson(json['season-player'])
            : null,
        shirtEdition: json['shirt-edition'] != null
            ? ShirtEdition.fromJson(json['shirt-edition'])
            : null,
      );
}

class Account {
  final int id;
  String? username;
  final String email;
  String? firstName;
  String? lastName;
  String? gender;
  String? address;
  String? phone;
  Dob? dob;
  final String supabaseId;
  final String role;
  String? status;

  Account({
    required this.id,
    this.username,
    required this.email,
    this.firstName,
    this.lastName,
    this.gender,
    this.address,
    this.phone,
    this.dob,
    required this.supabaseId,
    required this.role,
    this.status,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        firstName: json['first-name'],
        lastName: json['last-name'],
        gender: json['gender'],
        address: json['address'],
        phone: json['phone'],
        dob: json['dob'] != null ? Dob.fromJson(json['dob']) : null, 
        supabaseId: json['supabase-id'],
        role: json['role'],
        status: json['status'],
      );
}

class Dob {
  final int year;
  final int month;
  final int day;
  final int dayOfWeek;
  final int dayOfYear;
  final int dayNumber;

  Dob({
    required this.year,
    required this.month,
    required this.day,
    required this.dayOfWeek,
    required this.dayOfYear,
    required this.dayNumber,
  });

  factory Dob.fromJson(Map<String, dynamic> json) => Dob(
        year: json['year'],
        month: json['month'],
        day: json['day'],
        dayOfWeek: json['day-of-week'],
        dayOfYear: json['day-of-year'],
        dayNumber: json['day-number'],
      );
}

class ShirtImage {
  final int id;
  String? url;
  final int shirtId;

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

class OrderDetail {
  final int orderId;
  final int shirtId;
  final String code;
  final double subtotal;
  final int quantity;
  final String status;

  OrderDetail({
    required this.orderId,
    required this.shirtId,
    required this.code,
    required this.subtotal,
    required this.quantity,
    required this.status,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderId: json['order-id'],
        shirtId: json['shirt-id'],
        code: json['code'],
        subtotal: (json['subtotal'] as num).toDouble(),
        quantity: json['quantity'],
        status: json['status'],
      );
}

class SeasonPlayer {
  final int id;
  final int seasonId;
  final int playerId;
  final Player player;
  final Season season;

  SeasonPlayer({
    required this.id,
    required this.seasonId,
    required this.playerId,
    required this.player,
    required this.season,
  });

  factory SeasonPlayer.fromJson(Map<String, dynamic> json) {
    return SeasonPlayer(
      id: json['id'],
      seasonId: json['season-id'],
      playerId: json['player-id'],
      player: Player.fromJson(json['player']),
      season: Season.fromJson(json['season']),
    );
  }
}

class Season {
  final int id;
  String? code;
  final String name;
  int? clubId;
  final DateTime createdDate;
  final int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;
  final String status;
  Club? club;

  Season(
      {required this.id,
      this.code,
      required this.name,
      this.clubId,
      required this.createdDate,
      required this.createdAccountId,
      this.modifiedDate,
      this.modifiedAccountId,
      required this.status,
      this.club});

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      clubId: json['club-id'],
      createdDate: DateTime.parse(json['created-date']),
      createdAccountId: json['created-account-id'],
      modifiedDate: json['modified-date'] != null
          ? DateTime.parse(json['modified-date'])
          : null,
      modifiedAccountId: json['modified-account-id'] != null ? int.parse(json['modified-account-id']) : null,
      status: json['status'],
      club: Club.fromJson(json['club']),
    );
  }
}

class Club {
  final int id;
  String? code;
  final String name;
  String? logoUrl;
  final String status;
  final DateTime createdDate;
  final int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;

  Club({
    required this.id,
    this.code,
    required this.name,
    this.logoUrl,
    required this.status,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
  });

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      logoUrl: json['logo-url'],
      status: json['status'],
      createdDate: DateTime.parse(json['created-date']),
      createdAccountId: json['created-account-id'],
      modifiedDate: json['modified-date'] != null
          ? DateTime.parse(json['modified-date'])
          : null,
      modifiedAccountId: json['modified-account-id'],
    );
  }
}

class Player {
  final int id;
  final String code;
  final String name;
  final String status;
  final int clubId;
  final DateTime createdDate;
  final int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;

  Player({
    required this.id,
    required this.code,
    required this.name,
    required this.status,
    required this.clubId,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      status: json['status'],
      clubId: json['club-id'],
      createdDate: DateTime.parse(json['created-date']),
      createdAccountId: json['created-account-id'],
      modifiedDate: json['modified-date'] != null
          ? DateTime.parse(json['modified-date'])
          : null,
      modifiedAccountId: json['modified-account-id'] != null ? int.parse(json['modified-account-id']) : null,
    );
  }
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
  DateTime? modifiedDate;
  int? modifiedAccountId;

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
      modifiedAccountId: json['modified-account-id'] != null ? int.parse(json['modified-account-id']) : null,
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
