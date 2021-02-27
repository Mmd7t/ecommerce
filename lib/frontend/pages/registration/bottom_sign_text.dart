import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class BottomSignText extends StatelessWidget {
  final String text1;
  final String text2;
  final Function onClick;

  const BottomSignText({this.text1, this.text2, this.onClick});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        GestureDetector(
          onTap: onClick,
          child: GradientWidget(
            child: Text(
              text2,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
      ],
    );
  }
}
