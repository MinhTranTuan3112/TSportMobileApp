class AddToCartRequest {
  int shirtId;
  int quantity;
  String size;
  AddToCartRequest(
      {required this.shirtId, required this.quantity, required this.size});

  Map<String, dynamic> toJson() => {
        "shirt-id": shirtId,
        "quantity": quantity,
        "size": size,
      };
}
