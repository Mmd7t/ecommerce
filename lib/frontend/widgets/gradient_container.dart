import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final double radius;
  final double width;
  final double height;
  final EdgeInsets padding;
  final double opacity;
  final AlignmentGeometry alignment;
  const GradientContainer({
    this.alignment,
    this.opacity,
    this.padding,
    @required this.child,
    @required this.radius,
    this.width,
    this.height,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 650),
      curve: Curves.easeInOut,
      padding: (padding == null) ? const EdgeInsets.all(0) : padding,
      alignment: (alignment == null) ? Alignment.center : alignment,
      width: width,
      height: height,
      child: child,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: [
            Theme.of(context)
                .accentColor
                .withOpacity((opacity == null) ? 1 : opacity),
            Theme.of(context)
                .primaryColor
                .withOpacity((opacity == null) ? 1 : opacity),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
