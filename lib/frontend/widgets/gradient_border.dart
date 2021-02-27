import 'package:flutter/material.dart';

import 'gradient_container.dart';

class GradientBorder extends StatelessWidget {
  final double radius;
  final double width;
  final double height;
  final Widget child;
  final double opacity;
  final double padding;
  final Color color;

  const GradientBorder({
    Key key,
    this.radius,
    this.color,
    this.width,
    this.height,
    @required this.child,
    this.opacity,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      radius: radius,
      width: width,
      height: height,
      padding: EdgeInsets.all((padding) ?? 2),
      opacity: (opacity) ?? 1,
      child: Container(
        alignment: Alignment.center,
        child: child,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: (color) ?? Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
