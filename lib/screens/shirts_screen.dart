import 'dart:io';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:tsport_mobile_app/models/shirt.dart';
import 'package:tsport_mobile_app/screens/filter_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tsport_mobile_app/services/shirt_service.dart';
import 'package:tsport_mobile_app/widgets/empty_indicator.dart';
import 'package:tsport_mobile_app/widgets/error_indicator.dart';
import 'package:tsport_mobile_app/widgets/shirt_card.dart';

class ShirtsScreen extends StatefulWidget {
  const ShirtsScreen({super.key});

  @override
  State<ShirtsScreen> createState() => _ShirtsScreenState();
}

String formatPrice(double price) {
  final formatter = NumberFormat('#,###', 'de_DE');
  return formatter.format(price);
}

class _ShirtsScreenState extends State<ShirtsScreen> {
  String sortOption = "Giá: cao - thấp";

  final PagingController<int, ShirtItem> _pagingController =
      PagingController(firstPageKey: 1);

  static const _pageSize = 4;
  List<String> _selectedSizes = [];
  double? _startPrice, _endPrice;
  List<int> _selectedClubIds = [];
  List<int> _selectedSeasonIds = [];
  List<int> _selectedPlayerIds = [];

  Future _showFilterScreenAndFetchSizes() async {
    // final selectedSizes = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const FilterScreen()),
    // );
    // if (selectedSizes != null) {
    //   _selectedSizes = selectedSizes;
    //   _pagingController.refresh(); // Refresh the list with the new filter
    // }

    final filterData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FilterScreen(
                  selectedSize: _selectedSizes,
                  selectedStartPrice: _startPrice,
                  selectedEndPrice: _endPrice,
                  selectedClubsIds: _selectedClubIds,
                  selectedSeasonIds: _selectedSeasonIds,
                  selectedPlayerIds: _selectedPlayerIds,
                )));

    if (filterData != null) {
      _selectedSizes = filterData.sizes;
      _startPrice = filterData.startPrice;
      _endPrice = filterData.endPrice;
      _selectedClubIds = filterData.selectedClubsIds;
      _selectedSeasonIds = filterData.selectedSeasonIds;
      _selectedPlayerIds = filterData.selectedPlayerIds;
      _pagingController.refresh();
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) async {
      await _fetchPage(pageKey);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future _fetchPage(int pageKey) async {
    try {
      // Replace this with your actual data fetching logic
      final shirtService = ShirtService();
      final newItems = await shirtService.fetchShirts(
          pageKey,
          _pageSize,
          _selectedSizes,
          _startPrice,
          _endPrice,
          _selectedClubIds,
          _selectedSeasonIds,
          _selectedPlayerIds,
          sortOption: sortOption);

      if (!mounted) return; // Check if the widget is still mounted

      final isLastPage = newItems.length < _pageSize;

      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      final errorMessage =
          error is HttpException ? error.message : 'An unknown error occurred';
      _pagingController.error = errorMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // categoryBar(),
        const SizedBox(
          height: 10,
        ),
        filterRow(context),
        shirtsView(),
      ],
    );
  }

  Widget shirtsView() {
    return Expanded(
      child: PagedGridView<int, ShirtItem>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<ShirtItem>(
          itemBuilder: (context, item, index) => ShirtCard(shirt: item),
          firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
            message: 'Failed to load shirts',
            onTryAgain: () => _pagingController.refresh(),
          ),
          noItemsFoundIndicatorBuilder: (context) => const EmptyIndicator(
            message: 'Không tìm thấy áo nào.',
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }

  Widget filterRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        filterOption(),
        _sortOption(context),
        const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Row(
            children: [Icon(Icons.dashboard)],
          ),
        )
      ],
    );
  }

  GestureDetector filterOption() {
    return GestureDetector(
      onTap: () async {
        await _showFilterScreenAndFetchSizes();
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          children: [
            Icon(Icons.filter_alt),
            SizedBox(width: 3),
            Text('Bộ lọc')
          ],
        ),
      ),
    );
  }

  GestureDetector _sortOption(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      child: const Text('Sắp xếp theo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22))),
                  Flexible(
                    child: ListView(
                      children: [
                        ListTile(
                          title: const Text('Giá: cao - thấp'),
                          onTap: () => {
                            setState(() {
                              sortOption = 'Giá: cao - thấp';
                              _pagingController.refresh();
                            }),
                            Navigator.pop(context)
                          },
                          selected: sortOption == 'Giá: cao - thấp',
                          selectedTileColor: Colors.red,
                          selectedColor: Colors.white,
                        ),
                        ListTile(
                            title: const Text('Giá: thấp - cao'),
                            onTap: () => {
                                  setState(() {
                                    sortOption = 'Giá: thấp - cao';
                                    _pagingController.refresh();
                                  }),
                                  Navigator.pop(context)
                                },
                            selected: sortOption == 'Giá: thấp - cao',
                            selectedTileColor: Colors.red,
                            selectedColor: Colors.white),
                        ListTile(
                            title: const Text('Mới nhất trước'),
                            onTap: () => {
                                  setState(() {
                                    sortOption = 'Mới nhất trước';
                                    _pagingController.refresh();
                                  }),
                                  Navigator.pop(context)
                                },
                            selected: sortOption == 'Mới nhất trước',
                            selectedTileColor: Colors.red,
                            selectedColor: Colors.white),
                      ],
                    ),
                  ),
                ],
              );
            })
      },
      child: Row(
        children: [
          const Icon(Icons.swap_vert),
          const SizedBox(width: 3),
          Text("Sắp xếp theo: $sortOption")
        ],
      ),
    );
  }

  // Widget sortOption(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () => {
  //       showModalBottomSheet(
  //           context: context,
  //           builder: (context) {
  //             return Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Container(
  //                     padding: const EdgeInsets.all(10),
  //                     child: const Text('Sắp xếp theo',
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 22))),
  //                 Flexible(
  //                   child: ListView(
  //                     children: [
  //                       ListTile(
  //                         title: const Text('Giá: cao - thấp'),
  //                         onTap: () => {
  //                           setState(() {
  //                             sortOrder = 'Giá: cao - thấp';
  //                           }),
  //                           Navigator.pop(context)
  //                         },
  //                         selected: sortOrder == 'Giá: cao - thấp',
  //                         selectedTileColor: Colors.red,
  //                         selectedColor: Colors.white,
  //                       ),
  //                       ListTile(
  //                           title: const Text('Giá: thấp - cao'),
  //                           onTap: () => {
  //                                 setState(() {
  //                                   sortOrder = 'Giá: thấp - cao';
  //                                 }),
  //                                 Navigator.pop(context)
  //                               },
  //                           selected: sortOrder == 'Giá: thấp - cao',
  //                           selectedTileColor: Colors.red,
  //                           selectedColor: Colors.white),
  //                       ListTile(
  //                           title: const Text('Mới nhất trước'),
  //                           onTap: () => {
  //                                 setState(() {
  //                                   sortOrder = 'Mới nhất trước';
  //                                 }),
  //                                 Navigator.pop(context)
  //                               },
  //                           selected: sortOrder == 'Mới nhất trước',
  //                           selectedTileColor: Colors.red,
  //                           selectedColor: Colors.white),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             );
  //           })
  //     },
  //     child: Row(
  //       children: [
  //         const Icon(Icons.swap_vert),
  //         const SizedBox(width: 3),
  //         Text("Sắp xếp theo: $sortOrder")
  //       ],
  //     ),
  //   );
  // }

  Column categoryBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      onPressed: () => {},
                      child: const Text('Shirt category')));
            },
          ),
        )
      ],
    );
  }
}
