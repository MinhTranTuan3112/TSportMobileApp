import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tsport_mobile_app/screens/shirts_screen.dart';
import 'package:tsport_mobile_app/widgets/bottom_navigation_bar.dart';
import 'package:flutter/widgets.dart';

final images = [
  "https://i.postimg.cc/5NB1R1L8/welcome-banner.jpg",
  "https://product.hstatic.net/1000341630/product/hong-nam6745_da517aea17ca4a0491ed4ba8931a6f5a_master.jpg",
  "https://product.hstatic.net/1000341630/product/hong-nam6780_66702964c0254425883c4c5f326f5ad5_master.jpg",
  "https://product.hstatic.net/1000341630/product/da_nang_hong_c25ca2dcc9d7494aadd00bc6c0aa8a87_master.png",
  "https://static.vecteezy.com/system/resources/previews/000/834/768/original/beach-scene-summer-sale-banner-vector.jpg",
  "https://store4.manutd.com/content/ws/all/a1648baa-f5a1-48b6-82ab-930af17202a5__1600X752.png"
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
       mainTopImage() ,ShopNow() , 
        ],
       
      ),
    );
  }
  

  Widget extraImages() {
    return Expanded(
      // Wrap with Expanded to take up remaining space
      child: SingleChildScrollView(
        // Allows the column to scroll if it overflows
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Space the children evenly
          children: [
            // Left Side
            Expanded(
              child: Column(
                children: [
                  // Top Child with Big Red Text
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: const Center(
                      child: Text(
                        'Big Red Text',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Add your other widgets here
                ],
              ),
            ),
            // Right Side
            // Add your right side widget here
          ],
        ),
      ),
    );
  }
   Widget ShopNow(){
     return  GestureDetector(
      onTap: ()=> ShirtsScreen(),
       child:
         Padding(padding: EdgeInsets.all(100),
                  child:Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                ),
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Text('Shop now',
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:  16,
                  )),
                ), // Adjust the opacity value to make the image darker or lighter
              )),
       
     ); 
          
   }
    Widget newCollection(){
     return  
         Padding(padding: EdgeInsets.all(5),
           child: 
             Container(
              child: CarouselSlider(
                     options: CarouselOptions(
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
              autoPlay: true,
                     ),
                     items:images
                .map((item) => Container(
                      child: Center(
                          child:
                              Image.network(item, fit: BoxFit.cover, width: 1000)),
                    ))
                .toList(),
                   )),
           
         );
    
       
    
          
   }
  Widget mainTopImage() {
    return SizedBox(
    
      width: double.infinity, // Make the container take the full screen width
      height:
          200, // Specify the height to ensure the Stack has a bounded height
      child: Column(
        children: [
           Image.network(
              // 'https://bizweb.dktcdn.net/100/272/718/products/gkmu8.jpg?v=1648561904297'
              'https://i.postimg.cc/5NB1R1L8/welcome-banner.jpg',
              width: double.infinity,
              height: 200,
               // Cover the full width, maintaining aspect ratio
            ),
          





          
        // Container(
        //     decoration: BoxDecoration(
        //       color: Colors.grey[900],
        //       borderRadius: BorderRadius.circular(12),
        //     ),
        //     padding: const EdgeInsets.all(25),
        //     child: const Center(
        //       child: Text('Shop now',
        //       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:  16,
        //       )),
        //     ), // Adjust the opacity value to make the image darker or lighter
        //   ),
          
        ],
      ),
     ); 
  }

  Widget carousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.amber,
                  ),
                  child: Image.network(image, fit: BoxFit.cover),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: const Text(
                      'Sản phẩm mới',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
