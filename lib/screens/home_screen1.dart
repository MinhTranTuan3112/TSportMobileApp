import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

final List<String> images = [
  "https://product.hstatic.net/1000341630/product/hong-nam6745_da517aea17ca4a0491ed4ba8931a6f5a_master.jpg",
  "https://product.hstatic.net/1000341630/product/hong-nam6780_66702964c0254425883c4c5f326f5ad5_master.jpg",
  "https://product.hstatic.net/1000341630/product/da_nang_hong_c25ca2dcc9d7494aadd00bc6c0aa8a87_master.png"
];

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  _HomeScreen1State createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {

  @override
  Widget build(BuildContext context) {
     return Scaffold(
   
      body: Container(
          child: CarouselSlider(
        options: CarouselOptions(),
        items: images
            .map((item) => Container(
                  child: Center(
                      child:
                          Image.network(item, fit: BoxFit.cover, width: 1000)),
                ))
            .toList(),
      )));
  }
  }


