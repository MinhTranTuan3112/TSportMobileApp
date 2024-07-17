import 'package:tsport_mobile_app/models/order_in_cart.dart';

class AccountDetails {
  int id;
  String? username;
  String email;
  String password;
  String? firstName;
  String? lastName;
  String? gender;
  String? address;
  String? phone;
  Dob? dob;
  String supabaseId;
  String role;
  String status;
  List<OrderCreatedAccount> orderCreatedAccounts;

  AccountDetails({
    required this.id,
    this.username,
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
    this.gender,
    this.address,
    required this.phone,
    this.dob,
    required this.supabaseId,
    required this.role,
    required this.status,
    required this.orderCreatedAccounts,
  });

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
        id: json['id'],
        username: json['username'],
        email: json['email'],
        password: json['password'],
        firstName: json['first-name'],
        lastName: json['last-name'],
        gender: json['gender'],
        address: json['address'],
        phone: json['phone'],
        dob: json['dob'] != null ? Dob.fromJson(json['dob']) : null,
        supabaseId: json['supabase-id'],
        role: json['role'],
        status: json['status'],
        orderCreatedAccounts: json['order-created-accounts'] != null &&
                json['order-created-accounts'] != []
            ? List<OrderCreatedAccount>.from(json['order-created-accounts']
                .map((x) => OrderCreatedAccount.fromJson(x)))
            : [],
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

class OrderCreatedAccount {
  int id;
  String? code;
  DateTime orderDate;
  String status;
  double total;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;
  List<OrderDetail> orderDetails;
  List<Payment> payments;

  OrderCreatedAccount({
    required this.id,
    required this.code,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
    required this.orderDetails,
    required this.payments,
  });

  factory OrderCreatedAccount.fromJson(Map<String, dynamic> json) =>
      OrderCreatedAccount(
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
        orderDetails:
            json['order-details'] != null && json['order-details'] != []
                ? List<OrderDetail>.from(
                    json['order-details'].map((x) => OrderDetail.fromJson(x)))
                : [],
        payments: json['payments'] != null && json['payments'] != []
            ? List<Payment>.from(
                json['payments'].map((x) => Payment.fromJson(x)))
            : [],
      );
}

// Include OrderDetail, Payment, and any other classes as needed based on the JSON structure.
class OrderDetail {
  int orderId;
  int shirtId;
  String code;
  String size;
  double subtotal;
  int quantity;
  String? status;
  Shirt shirt;

  OrderDetail({
    required this.orderId,
    required this.shirtId,
    required this.code,
    required this.size,
    required this.subtotal,
    required this.quantity,
    this.status,
    required this.shirt,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        orderId: json['order-id'],
        shirtId: json['shirt-id'],
        code: json['code'],
        size: json['size'],
        subtotal: json['subtotal'].toDouble(),
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
  ShirtEdition? shirtEdition;

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
    this.shirtEdition,
  });

  factory Shirt.fromJson(Map<String, dynamic> json) => Shirt(
        id: json['id'],
        code: json['code'],
        name: json['name'],
        description: json['description'],
        quantity: json['quantity'],
        status: json['status'],
        shirtEditionId: json['shirt-edition-id'],
        seasonPlayerId: json['season-player-id'],
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] != null
            ? DateTime.parse(json['modified-date'])
            : null,
        modifiedAccountId: json['modified-account-id'] != null
            ? int.parse(json['modified-account-id'])
            : null,
        images: json['images'] != null && json['images'] != []
            ? List<ShirtImage>.from(
                json['images'].map((x) => ShirtImage.fromJson(x)))
            : [],
        shirtEdition: json['shirt-edition'] != null
            ? ShirtEdition.fromJson(json['shirt-edition'])
            : null,
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
      modifiedAccountId: json['modified-account-id'] != null
          ? int.parse(json['modified-account-id'])
          : null,
    );
  }
}

class Payment {
  int id;
  String? code;
  String? paymentMethod;
  String? paymentName;
  String status;
  int? orderId;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;

  Payment({
    required this.id,
    this.code,
    this.paymentMethod,
    this.paymentName,
    required this.status,
    this.orderId,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json['id'],
        code: json['code'],
        paymentMethod: json['payment-method'],
        paymentName: json['payment-name'],
        status: json['status'],
        orderId: json['order-id'] != null ? int.parse(json['order-id']) : null,
        createdDate: DateTime.parse(json['created-date']),
        createdAccountId: json['created-account-id'],
        modifiedDate: json['modified-date'] != null
            ? DateTime.parse(json['modified-date'])
            : null, // Handling nullable DateTime
        modifiedAccountId: json['modified-account-id'] != null
            ? int.parse(json['modified-account-id'])
            : null,
      );
}
