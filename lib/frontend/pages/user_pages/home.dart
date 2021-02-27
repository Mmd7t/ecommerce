import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/global_carousel.dart';
import 'package:ecommerce/frontend/widgets/global_grid.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      child: SingleChildScrollView(
        child: Column(
          children: [
            GlobalCarousel(),
            GlobalGrid(),
          ],
        ),
      ),
    );
  }
}
