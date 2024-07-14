class ShirtFilterData {
  List<String> sizes;
  double? startPrice;
  double? endPrice;

  ShirtFilterData({List<String>? sizes, this.startPrice, this.endPrice})
      : sizes = sizes ?? [];
}
