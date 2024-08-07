class UpdateAccountRequest {
  String? firstName;
  String? lastName;
  String? gender;
  String? address;
  String? phone;

  UpdateAccountRequest(
      {this.firstName, this.lastName, this.gender, this.address, this.phone});

  Map<String, dynamic> toJson() => {
        "first-name": firstName,
        "last-name": lastName,
        "gender": gender,
        "address": address,
        "phone": phone,
      };
}
