import 'package:ecommerce/frontend/widgets/global_btn.dart';
import 'package:flutter/material.dart';

class SignBtn extends StatelessWidget {
  final Function onClick;
  final String text;

  const SignBtn({@required this.onClick, this.text});
  @override
  Widget build(BuildContext context) {
    return GlobalBtn(
      text: text,
      onClick: onClick,
      width: MediaQuery.of(context).size.width * 0.3,
      height: 40,
    );
  }
}
