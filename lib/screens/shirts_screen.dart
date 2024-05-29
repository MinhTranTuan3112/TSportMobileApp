import 'package:flutter/material.dart';

class ShirtsScreen extends StatefulWidget {
  const ShirtsScreen({super.key});

  @override
  State<ShirtsScreen> createState() => _ShirtsScreenState();
}

class _ShirtsScreenState extends State<ShirtsScreen> {
  String sortOrder = "Giá: cao - thấp";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        categoryBar(),
        Row(
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
        )
      ],
    );
  }

  Padding filterOption() {
    return const Padding(
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [Icon(Icons.filter_alt), SizedBox(width: 3), Text('Bộ lọc')],
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
