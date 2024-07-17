class ShirtFilterData {
  List<String> sizes;
  double? startPrice;
  double? endPrice;
  List<int> selectedClubsIds;
  List<int> selectedSeasonIds;
  List<int> selectedPlayerIds;

  ShirtFilterData({List<String>? sizes, this.startPrice, this.endPrice, List<int>? selectedClubsIds, List<int>? selectedSeasonIds,
  List<int>? selectedPlayerIds})
      : sizes = sizes ?? [],
        selectedClubsIds = selectedClubsIds ?? [],
        selectedSeasonIds = selectedSeasonIds ?? [],
        selectedPlayerIds = selectedPlayerIds ?? [];
}
