import 'package:tsport_mobile_app/models/shirt.dart';

class OrderDetailsInfo {
  int id;
  String? code;
  DateTime orderDate;
  String status;
  double total;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;
  Account createdAccount;
  Account? modifiedAccount;
  List<OrderDetail> orderDetails;
  List<Payment> payments;

  OrderDetailsInfo({
    required this.id,
    this.code,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.createdDate,
    required this.createdAccountId,
    this.modifiedDate,
    this.modifiedAccountId,
    required this.createdAccount,
    this.modifiedAccount,
    required this.orderDetails,
    required this.payments,
  });

  factory OrderDetailsInfo.fromJson(Map<String, dynamic> json) =>
      OrderDetailsInfo(
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
        createdAccount: Account.fromJson(json['created-account']),
        modifiedAccount: json['modified-account'] != null
            ? Account.fromJson(json['modified-account'])
            : null,
        orderDetails: List<OrderDetail>.from(
            json['order-details'].map((x) => OrderDetail.fromJson(x))),
        payments: List<Payment>.from(
            json['payments'].map((x) => Payment.fromJson(x))),
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

class OrderDetail {
  int orderId;
  int shirtId;
  String? code;
  String size;
  double subtotal;
  int quantity;
  String? status;
  final ShirtItem shirt;

  OrderDetail({
    required this.orderId,
    required this.shirtId,
    this.code,
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
        subtotal: (json['subtotal'] as num).toDouble(),
        quantity: json['quantity'],
        status: json['status'],
        shirt: ShirtItem.fromJson(json['shirt']),
      );
}

class Payment {
  int id;
  String? code;
  String? paymentMethod;
  String? paymentName;
  double amount;
  String status;
  int? orderId;
  DateTime createdDate;
  int createdAccountId;
  DateTime? modifiedDate;
  int? modifiedAccountId;

  Payment({
    required this.id,
    required this.code,
    this.paymentMethod,
    this.paymentName,
    required this.amount,
    required this.status,
    required this.orderId,
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
        amount: json['amount'].toDouble(),
        status: json['status'],
        orderId: json['order-id'] != null ? int.parse(json['order-id']) : null,
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
