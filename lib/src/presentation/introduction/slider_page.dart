import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});
  @override
  _CarouselState createState() => _CarouselState();

}

class _CarouselState extends State<SliderPage> {
  final CarouselController _controller = CarouselController();
  List _isSelected = [true, false, false, false, false, false, false];
  int _current = 0;

  final List<String> imgList = [
    'assets/images/slider1.png',
    'assets/images/slider5.png',
    'assets/images/slider3.png',
    'assets/images/slider4.png',
    'assets/images/slider2.png'
  ];

  List<Widget> generateImageTiles(screenSize) {
    return imgList.map((element) => ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        element,
        fit: BoxFit.cover,
      ),
    ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var imageSliders = generateImageTiles(screenSize);
    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 18 / 8,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                  for (int i = 0; i < imageSliders.length; i++) {
                    if (i == index) {
                      _isSelected[i] = true;
                    } else {
                      _isSelected[i] = false;
                    }
                  }
                });
              }),
          carouselController: _controller,
        ),
      ],
    );
  }
}