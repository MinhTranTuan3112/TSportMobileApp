class ShirtFilterData {
  List<String> sizes;
  double? startPrice;
  double? endPrice;
  List<int> selectedClubsIds;

  ShirtFilterData({List<String>? sizes, this.startPrice, this.endPrice, List<int>? selectedClubsIds})
      : sizes = sizes ?? [],
        selectedClubsIds = selectedClubsIds ?? [];
}
