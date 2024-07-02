import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tsport_mobile_app/models/shirt_details.dart';
import 'package:tsport_mobile_app/services/shirt_service.dart';
import 'package:tsport_mobile_app/widgets/color_dropdown_button.dart';
import 'package:tsport_mobile_app/widgets/size_dropdown_button.dart';

// final images = [
//   "https://product.hstatic.net/1000341630/product/hong-nam6745_da517aea17ca4a0491ed4ba8931a6f5a_master.jpg",
//   "https://product.hstatic.net/1000341630/product/hong-nam6780_66702964c0254425883c4c5f326f5ad5_master.jpg",
//   "https://product.hstatic.net/1000341630/product/da_nang_hong_c25ca2dcc9d7494aadd00bc6c0aa8a87_master.png"
// ];

class ShirtDetailsScreen extends StatefulWidget {
  final int shirtId;
  const ShirtDetailsScreen({super.key, required this.shirtId});

  @override
  State<ShirtDetailsScreen> createState() => _ShirtDetailsScreenState();
}

class _ShirtDetailsScreenState extends State<ShirtDetailsScreen> {
  int _current = 0;
  ShirtDetails? _shirt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Áo đấu'),
      ),
      body: mainContent(),
      bottomNavigationBar: addToCartButton(),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchShirtDetails();
  }

  Future fetchShirtDetails() async {
    var shirtDetails =
        await ShirtService().fetchShirtDetailsById(widget.shirtId);
    setState(() {
      _shirt = shirtDetails;
    });
  }

  Widget addToCartButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            minimumSize:
                WidgetStateProperty.all<Size>(const Size(double.infinity, 50))),
        child: const Text('THÊM VÀO GIỎ HÀNG'),
      ),
    );
  }

  Widget mainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          imagesCarousel(),
          const Row(
            children: [
              SizedBox(width: 10),
              SizeDropdownButton(),
              SizedBox(width: 10),
              ColorDropdownButton()
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      _shirt!.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Text(
                      'Mùa giải: ${_shirt!.seasonPlayer!.season.name}',
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      'Câu lạc bộ: ${_shirt!.seasonPlayer!.season.club!.name}',
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    Text(
                      'Cầu thủ: ${_shirt!.seasonPlayer!.player.name}',
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    )
                  ],
                ),
                Text(
                  '${_shirt?.shirtEdition?.discountPrice} VNĐ',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '${_shirt?.description}',
              textAlign: TextAlign.justify,
              style: const TextStyle(),
            ),
          ),
        ],
      ),
    );
  }

  Widget imagesCarousel() {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _shirt?.images.length,
          options: CarouselOptions(
              height: 400,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          itemBuilder: (context, index, realIdx) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.network(_shirt?.images[index].url ?? '',
                  fit: BoxFit.cover),
            );
          },
        ),
        Slider(
            value: _current.toDouble(),
            min: 0,
            max: _shirt!.images.length.toDouble() - 1,
            onChanged: (double value) {
              setState(() {
                _current = value.round();
              });
            }),
      ],
    );
  }
}
