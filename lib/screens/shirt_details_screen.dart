import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:tsport_mobile_app/models/shirt_details.dart';
import 'package:tsport_mobile_app/screens/login_screen.dart';
import 'package:tsport_mobile_app/services/auth_service.dart';
import 'package:tsport_mobile_app/services/order_service.dart';
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
  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  String? _selectedSize;
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chi tiết áo'),
      ),
      body: _shirt == null
          ? const Center(child: CircularProgressIndicator())
          : mainContent(),
      bottomNavigationBar: addToCartContent(),
    );
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
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

  Widget addToCartContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 300,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Số lượng',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter
                              .digitsOnly, // Only numbers can be entered
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Nhập số lượng',
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text('Size'),
                          const SizedBox(width: 10),
                          sizeSelect(),
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              bool isAuthenticated =
                                  await AuthService().checkAuthenticated();
                              if (!isAuthenticated) {
                                Navigator.push(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                                return;
                              }

                              final bool? confirmed = await showDialog<bool>(
                                // ignore: use_build_context_synchronously
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Xác nhận'),
                                    content: const Text(
                                        'Bạn có muốn thêm sản phẩm vào giỏ hàng không?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context)
                                            .pop(false), // User presses "No"
                                        child: const Text('Không'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context)
                                            .pop(true), // User presses "Yes"
                                        child: const Text('Có'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (confirmed != null && confirmed == false) {
                                return;
                              }

                              // ignore: use_build_context_synchronously
                              await handleAddToCart(context);
                            },
                            child: const Text('THÊM VÀO GIỎ HÀNG')),
                      )
                    ],
                  ),
                );
              });
        },
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            minimumSize:
                WidgetStateProperty.all<Size>(const Size(double.infinity, 50))),
        child: const Text('THÊM VÀO GIỎ HÀNG'),
      ),
    );
  }

  DropdownButton<String> sizeSelect() {
    return DropdownButton<String>(
                          value: _selectedSize,
                          icon: const Icon(Icons.arrow_downward),
                          elevation: 16,
                          style: const TextStyle(color: Colors.red),
                          underline: Container(
                            height: 2,
                            color: Colors.red,
                          ),
                          onChanged: (String? newValue) {
                            // Update the state to reflect the new selected size
                            setState(() {
                              _selectedSize = newValue;
                            });
                          },
                          items: _sizes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        );
  }

  Future<void> handleAddToCart(BuildContext context) async {
    try {
      String quantityStr = _quantityController.text;
      int quantity =
          int.tryParse(quantityStr) ?? 1; // Default to 0 if parsing fails
      int shirtId = _shirt!.id;
      await OrderService().callAddToCart(shirtId, quantity, _selectedSize!);
      // Show success dialog
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Thành công'),
            content: const Text('Thêm sản phẩm vào giỏ hàng thành công'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Widget mainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          imagesCarousel(),
          // const Row(
          //   children: [
          //     SizedBox(width: 10),
          //     SizeDropdownButton(),
          //     SizedBox(width: 10),
          //     ColorDropdownButton()
          //   ],
          // ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_shirt?.shirtEdition?.discountPrice != null) ...[
                  Text.rich(
                    TextSpan(
                      text: '${_shirt?.shirtEdition?.stockPrice} VNĐ',
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: 10), // Space between stockPrice and discountPrice
                  Text(
                    '${_shirt?.shirtEdition?.discountPrice} VNĐ',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ] else ...[
                  Text(
                    '${_shirt?.shirtEdition?.stockPrice} VNĐ',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '${_shirt?.name}',
              textAlign: TextAlign.justify,
              style: const TextStyle(),
            ),
          ),
          const SizedBox(height: 10),
          Text('Câu lạc bộ: ${_shirt?.seasonPlayer?.season.club?.name}')
        ],
      ),
    );
  }

  Widget imagesCarousel() {
    return _shirt?.images != []
        ? Column(
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
          )
        : const SizedBox();
  }
}
