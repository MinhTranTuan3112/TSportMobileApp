class AddToCartRequest {
  int shirtId;
  int quantity;
  String size;
  AddToCartRequest(
      {required this.shirtId, required this.quantity, required this.size});
}
