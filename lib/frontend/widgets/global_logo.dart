import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';

import 'gradient_widget.dart';

class GlobalLogo extends StatelessWidget {
  final double size;

  const GlobalLogo({Key key, this.size}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GradientWidget(
      child: Text(
        mAppName,
        style: globalTextStyle.copyWith(fontSize: size),
      ),
    );
  }
}
