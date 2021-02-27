import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';

class SocialSignBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onClick;

  const SocialSignBtn({Key key, this.icon, this.color, this.onClick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GradientBorder(
      radius: 100,
      height: 50,
      width: 50,
      child: IconButton(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        onPressed: onClick,
        icon: Icon(
          icon,
          size: 20,
          color: color,
        ),
      ),
    );
  }
}
