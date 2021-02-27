import 'package:flutter/material.dart';

class GlobalIndicators extends StatelessWidget {
  final int length;
  final int currentIndex;

  const GlobalIndicators({Key key, this.length, this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.all(3),
            width: (index == currentIndex) ? 12 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: (index == currentIndex)
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(50),
            ),
          );
        },
      ),
    );
  }
}
