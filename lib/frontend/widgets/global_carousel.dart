import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'global_indicators.dart';
import 'gradient_container.dart';

class GlobalCarousel extends StatefulWidget {
  @override
  _GlobalCarouselState createState() => _GlobalCarouselState();
}

class _GlobalCarouselState extends State<GlobalCarousel> {
  int current;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        /*---------------------------------  Carousel Slider  -----------------------------------*/
        CarouselSlider.builder(
          itemCount: 5,
          options: CarouselOptions(
            viewportFraction: 1,
            enableInfiniteScroll: false,
            initialPage: 0,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
            pageSnapping: true,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GradientContainer(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Text("data"),
                radius: 20,
              ),
            );
          },
        ),
        /*---------------------------------  Indicators  -----------------------------------*/
        GlobalIndicators(
          length: 5,
          currentIndex: current,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
