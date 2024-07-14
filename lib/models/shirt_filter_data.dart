class ShirtFilterData {
  List<String> sizes;
  double? startPrice;
  double? endPrice;
  List<int> selectedClubsIds;
  List<int> selectedSeasonIds;

  ShirtFilterData({List<String>? sizes, this.startPrice, this.endPrice, List<int>? selectedClubsIds, List<int>? selectedSeasonIds})
      : sizes = sizes ?? [],
        selectedClubsIds = selectedClubsIds ?? [],
        selectedSeasonIds = selectedSeasonIds ?? [];
}
