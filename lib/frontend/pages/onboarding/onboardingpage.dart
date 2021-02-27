import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            Container(
              child: SvgPicture.asset(
                "assets/wallet.svg",
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            ),
            SizedBox(height: 25),
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
