import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tsport_mobile_app/models/club_filter.dart';
import 'package:tsport_mobile_app/models/player_filter.dart';
import 'package:tsport_mobile_app/models/season_filter.dart';
import 'package:tsport_mobile_app/models/shirt_filter_data.dart';
import 'package:tsport_mobile_app/services/club_service.dart';
import 'package:tsport_mobile_app/services/player_service.dart';
import 'package:tsport_mobile_app/services/season_service.dart';
import 'package:tsport_mobile_app/utils/price_utils.dart';

class FilterScreen extends StatefulWidget {
  final List<String> selectedSize;
  final double? selectedStartPrice;
  final double? selectedEndPrice;
  final List<int> selectedClubsIds;
  final List<int> selectedSeasonIds;
  final List<int> selectedPlayerIds;

  const FilterScreen(
      {super.key,
      required this.selectedSize,
      this.selectedStartPrice,
      this.selectedEndPrice,
      required this.selectedClubsIds,
      required this.selectedSeasonIds,
      required this.selectedPlayerIds});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues currentRangeValues = const RangeValues(0, 500000);

  List<ClubFilter> _clubs = [];
  List<SeasonFilter> _seasons = [];
  List<PlayerFilter> _players = [];

  var sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  var sizeSelectedMap = {
    'S': false,
    'M': false,
    'L': false,
    'XL': false,
    'XXL': false
  };

  Map<int, bool> clubSelectedMap = {};
  Map<int, bool> seasonSelectedMap = {};
  Map<int, bool> playerSelectedMap = {};

  @override
  void initState() {
    super.initState();
    for (var size in widget.selectedSize) {
      sizeSelectedMap[size] = true;
    }

    if (widget.selectedStartPrice != null && widget.selectedEndPrice != null) {
      currentRangeValues =
          RangeValues(widget.selectedStartPrice!, widget.selectedEndPrice!);
    }

    fetchClubsFilter();
    fetchSeasonsFilter();
    fetchPlayersFilter();
  }

  Future fetchSeasonsFilter() async {
    final seasons = await SeasonService().fetchSeasonFilters();
    setState(() {
      _seasons = seasons;
    });

    for (var season in _seasons) {
      if (widget.selectedSeasonIds.contains(season.id)) {
        seasonSelectedMap[season.id] = true;
        continue;
      }
      seasonSelectedMap[season.id] = false;
    }
  }

  Future fetchClubsFilter() async {
    final clubs = await ClubService().fetchClubsFilters();
    setState(() {
      _clubs = clubs;
    });

    for (var club in _clubs) {
      if (widget.selectedClubsIds.contains(club.id)) {
        clubSelectedMap[club.id] = true;
        continue;
      }
      clubSelectedMap[club.id] = false;
    }
  }

  Future fetchPlayersFilter() async {
    final players = await PlayerService().fetchPlayerFilters();
    setState(() {
      _players = players;
    });

    for (var player in _players) {
      if (widget.selectedPlayerIds.contains(player.id)) {
        playerSelectedMap[player.id] = true;
        continue;
      }
      playerSelectedMap[player.id] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bộ lọc'),
      ),
      body: Column(
        children: [
          priceFilterSection(),
          sizeFilterSection(),
          const SizedBox(height: 20),
          clubsFilterSection(),
          const SizedBox(height: 20),
          seasonFilterSection(),
          applyButton()
        ],
      ),
    );
  }

  Widget applyButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () {
            var selectedSizes = sizeSelectedMap.entries
                .where((e) => e.value == true)
                .map((e) => e.key)
                .toList();

            var selectedClubsIds = clubSelectedMap.entries
                .where((e) => e.value == true)
                .map((e) => e.key)
                .toList();

            var selectedSeasonIds = seasonSelectedMap.entries
                .where((e) => e.value == true)
                .map((e) => e.key)
                .toList();

            var selectedPlayerIds = playerSelectedMap.entries
                .where((e) => e.value == true)
                .map((e) => e.key)
                .toList();

            var startPrice = currentRangeValues.start.round().toDouble();
            var endPrice = currentRangeValues.end.round().toDouble();

            var filterData = ShirtFilterData(
                sizes: selectedSizes,
                selectedClubsIds: selectedClubsIds,
                selectedSeasonIds: selectedSeasonIds,
                selectedPlayerIds: selectedPlayerIds);

            if (startPrice < endPrice) {
              filterData.startPrice = startPrice;
              filterData.endPrice = endPrice;
            }

            // Navigator.pop(context, selectedSizes);
            Navigator.pop(context, filterData);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              'Áp dụng',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          )),
    );
  }

  Widget sizeFilterSection() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Size',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: Wrap(
            spacing: 10,
            children: sizes.map((String size) {
              return ChoiceChip(
                label: Text(size),
                selected: sizeSelectedMap[size] ?? false,
                selectedColor: Colors.red,
                onSelected: (bool selected) {
                  setState(() {
                    sizeSelectedMap[size] = selected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget clubsFilterSection() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Câu lạc bộ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: Wrap(
            spacing: 10,
            children: _clubs.map((ClubFilter club) {
              return ChoiceChip(
                label: Text(club.name),
                selected: clubSelectedMap[club.id] ?? false,
                selectedColor: Colors.red,
                onSelected: (bool selected) {
                  setState(() {
                    clubSelectedMap[club.id] = selected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget seasonFilterSection() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Mùa giải',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: Wrap(
            spacing: 10,
            children: _seasons.map((SeasonFilter season) {
              return ChoiceChip(
                label: Text(season.name),
                selected: seasonSelectedMap[season.id] ?? false,
                selectedColor: Colors.red,
                onSelected: (bool selected) {
                  setState(() {
                    seasonSelectedMap[season.id] = selected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget playerFilterSection() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          margin: const EdgeInsets.only(top: 20),
          child: const Text(
            'Cầu thủ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: Wrap(
            spacing: 10,
            children: _players.map((PlayerFilter player) {
              return ChoiceChip(
                label: Text(player.name),
                selected: playerSelectedMap[player.id] ?? false,
                selectedColor: Colors.red,
                onSelected: (bool selected) {
                  setState(() {
                    playerSelectedMap[player.id] = selected;
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Column priceFilterSection() {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 10),
            child: const Text(
              'Khoảng giá',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: RangeSlider(
            values: currentRangeValues,
            min: 0,
            max: 500000,
            divisions: 10,
            labels: RangeLabels(
              '${PriceUtils.formatPrice(currentRangeValues.start.round().toDouble())} VNĐ',
              '${PriceUtils.formatPrice(currentRangeValues.end.round().toDouble())} VNĐ',
            ),
            onChanged: (RangeValues value) {
              setState(() {
                currentRangeValues = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
