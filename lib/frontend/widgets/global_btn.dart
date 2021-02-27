import 'package:flutter/material.dart';

import 'global_ink_well.dart';
import 'gradient_container.dart';

class GlobalBtn extends StatelessWidget {
  final String text;
  final Function onClick;
  final double width;
  final double height;
  final EdgeInsets padding;

  const GlobalBtn(
      {Key key, this.text, this.onClick, this.width, this.height, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GlobalSplash(
      onPressed: onClick,
      radius: 50,
      child: GradientContainer(
        padding: (padding == null) ? EdgeInsets.all(0) : padding,
        child: Text(
          text,
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.white),
        ),
        radius: 100,
        width: width,
        height: height,
      ),
    );
  }
}
