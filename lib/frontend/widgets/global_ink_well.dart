import 'package:flutter/material.dart';

class GlobalSplash extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final double radius;

  const GlobalSplash({Key key, this.onPressed, this.child, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: child,
      splashColor: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(radius),
    );
  }
}
