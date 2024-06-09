class Account {
  final String? email;
  final String? role;

  Account({this.email, this.role});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      email: json['email'],
      role: json['role'],
    );
  }

  
}
