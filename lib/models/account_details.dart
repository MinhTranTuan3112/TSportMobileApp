class AccountDetails {
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
  List<Order> orders;

  AccountDetails({
    required this.id,
    this.username,
    required this.email,
    this.firstName,
    this.lastName,
    required this.gender,
    required this.address,
    required this.phone,
    this.dob,
    required this.supabaseId,
    required this.role,
    this.status,
    required this.orders,
  });

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
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
        orders: json['order-created-accounts'] != null && json['order-created-accounts'] != [] ? List<Order>.from(json['order-created-accounts'].map((x) => Order.fromJson(x))) : [],
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

class Order {
  int id;
  String? code;
  DateTime orderDate;
  String status;
  double total;
  List<OrderDetail> orderDetails;

  Order({
    required this.id,
    this.code,
    required this.orderDate,
    required this.status,
    required this.total,
    required this.orderDetails,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        code: json['code'],
        orderDate: DateTime.parse(json['order-date']),
        status: json['status'],
        total: json['total'].toDouble(),
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
  String? status;
  Shirt shirt;

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
        shirt: Shirt.fromJson(json['shirt']),
      );
}

class Shirt {
  int id;
  String name;
  String description;
  ShirtEdition shirtEdition;

  Shirt({
    required this.id,
    required this.name,
    required this.description,
    required this.shirtEdition,
  });

  factory Shirt.fromJson(Map<String, dynamic> json) => Shirt(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        shirtEdition: ShirtEdition.fromJson(json['shirt-edition']),
      );
}

class ShirtEdition {
  String code;
  String color;
  String origin;

  ShirtEdition({
    required this.code,
    required this.color,
    required this.origin,
  });

  factory ShirtEdition.fromJson(Map<String, dynamic> json) => ShirtEdition(
        code: json['code'],
        color: json['color'],
        origin: json['origin'],
      );
}
