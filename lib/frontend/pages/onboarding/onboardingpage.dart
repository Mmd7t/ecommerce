import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class OnBoardingPage extends StatelessWidget {
  final String text;
  final String img;

  const OnBoardingPage({this.text, this.img});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(),
            const SizedBox(height: 25),
            GradientWidget(
              child: Text(
                text,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
