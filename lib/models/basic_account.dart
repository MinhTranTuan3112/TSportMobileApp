class BasicAccount {
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

  BasicAccount({
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
  });

  factory BasicAccount.fromJson(Map<String, dynamic> json) => BasicAccount(
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
