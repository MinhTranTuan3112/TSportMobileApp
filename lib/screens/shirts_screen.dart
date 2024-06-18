import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:tsport_mobile_app/screens/filter_screen.dart';
import 'package:tsport_mobile_app/screens/shirt_details_screen.dart';

class BasicShirt {
  final String name;
  final String imageUrl;
  final double price;

  BasicShirt({required this.name, required this.imageUrl, required this.price});
}

class ShirtsScreen extends StatefulWidget {
  const ShirtsScreen({super.key});

  @override
  State<ShirtsScreen> createState() => _ShirtsScreenState();
}

String formatPrice(double price) {
  final formatter = NumberFormat('#,###', 'de_DE');
  return formatter.format(price);
}

class ShirtCard extends StatefulWidget {
  final BasicShirt shirt;

  const ShirtCard({super.key, required this.shirt});

  @override
  State<ShirtCard> createState() => _ShirtCardState();
}

class _ShirtCardState extends State<ShirtCard> {
  List<String> sizes = [
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  var isSelected = {
    'S': false,
    'M': false,
    'L': false,
    'XL': false,
    'XXL': false
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ShirtDetailsScreen()))
          // showModalBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return StatefulBuilder(
          //           builder: (context, setState) => Container(
          //                 padding: const EdgeInsets.all(10),
          //                 child: Column(
          //                   children: [
          //                     const Text('Chọn size', style:
          //                     TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          //                     const SizedBox(
          //                       height: 10,
          //                     ),
          //                     SizedBox(
          //                       height:
          //                           MediaQuery.of(context).size.height * 0.4,
          //                       child: GridView.count(
          //                         crossAxisCount: 3,
          //                         crossAxisSpacing: 2,
          //                         // // mainAxisSpacing: 2,
          //                         childAspectRatio: 3 / 1,
          //                         children: sizes.map((String size) {
          //                           return SizedBox(
          //                             width: MediaQuery.of(context).size.width *
          //                                 0.3,
          //                             child: ChoiceChip(
          //                               visualDensity: const VisualDensity(horizontal: 0.0, vertical: -4), // Adjust the size
          //                               label: Text(size),
          //                               selected: isSelected[size] ?? false,
          //                               selectedColor: Colors.red,
          //                               onSelected: (bool selected) {
          //                                 setState(() {
          //                                   isSelected[size] = selected;
          //                                 });
          //                               },
          //                               shape: RoundedRectangleBorder(
          //                                 borderRadius:
          //                                     BorderRadius.circular(10),
          //                               ),
          //                             ),
          //                           );
          //                         }).toList(),
          //                       ),
          //                     ),
          //                     Container(
          //                       width: MediaQuery.of(context).size.width * 0.9,
          //                       decoration: const BoxDecoration(
          //                           borderRadius:
          //                               BorderRadius.all(Radius.circular(1))),
          //                       child: ElevatedButton(
          //                         onPressed: () => {},
          //                         style: ElevatedButton.styleFrom(
          //                             backgroundColor: Colors.red,
          //                             minimumSize: const Size(double.infinity, 40), // Set the height of the button
          //                             ),
          //                         child: const Text(
          //                           "THÊM VÀO GIỎ HÀNG",
          //                           style: TextStyle(

          //                             color: Colors.white,
          //                           ),
          //                         ),
          //                       ),
          //                     )
          //                   ],
          //                 ),
          //               ));
          //     })
        },
        child: Column(
          children: [
            Image.network(widget.shirt.imageUrl),
            const SizedBox(height: 10),
            Text(
              widget.shirt.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('${formatPrice(widget.shirt.price)} VNĐ')
          ],
        ),
      ),
    );
  }
}

class _ShirtsScreenState extends State<ShirtsScreen> {
  String sortOrder = "Giá: cao - thấp";
  var shirts = <BasicShirt>[
    BasicShirt(
        name: 'Áo thi đấu thể thao ĐN',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/hong-nam6745_da517aea17ca4a0491ed4ba8931a6f5a_master.jpg',
        price: 169000),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500),
    BasicShirt(
        name: 'Áo POLO Nam Porada',
        imageUrl:
            'https://product.hstatic.net/1000341630/product/mid06600_6c744f681d1f4a5a8ac7e71bd778620c_master.jpg',
        price: 149500)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        categoryBar(),
        const SizedBox(
          height: 10,
        ),
        filterRow(context),
        shirtsView(),
      ],
    );
  }

  Expanded shirtsView() {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: shirts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ShirtCard(shirt: shirts[i]),
      ),
    );
  }

  Row filterRow(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        filterOption(),
        sortOption(context),
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
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const FilterScreen()))
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

  GestureDetector sortOption(BuildContext context) {
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
                              sortOrder = 'Giá: cao - thấp';
                            }),
                            Navigator.pop(context)
                          },
                          selected: sortOrder == 'Giá: cao - thấp',
                          selectedTileColor: Colors.red,
                          selectedColor: Colors.white,
                        ),
                        ListTile(
                            title: const Text('Giá: thấp - cao'),
                            onTap: () => {
                                  setState(() {
                                    sortOrder = 'Giá: thấp - cao';
                                  }),
                                  Navigator.pop(context)
                                },
                            selected: sortOrder == 'Giá: thấp - cao',
                            selectedTileColor: Colors.red,
                            selectedColor: Colors.white),
                        ListTile(
                            title: const Text('Mới nhất trước'),
                            onTap: () => {
                                  setState(() {
                                    sortOrder = 'Mới nhất trước';
                                  }),
                                  Navigator.pop(context)
                                },
                            selected: sortOrder == 'Mới nhất trước',
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
          Text("Sắp xếp theo: $sortOrder")
        ],
      ),
    );
  }

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
