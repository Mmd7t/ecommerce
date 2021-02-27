import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final IconData showPassIcon;
  bool obscure;
  final Function onSave;
  final TextInputType kType;
  final TextInputAction inputAction;
  final Function validator;
  final int maxLines;
  final TextEditingController controller;
  final FocusNode focusNode;

  CustomTextField({
    @required this.hint,
    @required this.icon,
    this.validator,
    this.controller,
    this.inputAction,
    this.maxLines,
    this.kType,
    this.showPassIcon,
    this.obscure,
    @required this.onSave,
    this.focusNode,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState(obscure);
}

class _CustomTextFieldState extends State<CustomTextField> {
  // bool obs = false;

  _CustomTextFieldState(obs);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        keyboardAppearance: (theme.theme) ? Brightness.dark : Brightness.light,
        keyboardType: widget.kType,
        obscureText: (widget.obscure) ?? false,
        cursorColor: Theme.of(context).accentColor,
        maxLines: (widget.maxLines) ?? 1,
        onSaved: widget.onSave,
        validator: (value) {
          if (value.isEmpty) {
            return errorMessage(widget.hint);
          } else {
            return widget.validator(value);
          }
        },
        decoration: InputDecoration(
          labelText: widget.hint,
          suffixIcon: (widget.showPassIcon == null)
              ? SizedBox()
              : GradientWidget(
                  child: IconButton(
                    icon: Icon(widget.showPassIcon),
                    onPressed: () {
                      setState(() {
                        widget.obscure = !widget.obscure;
                      });
                    },
                  ),
                ),
          prefixIcon: GradientWidget(
            child: Icon(
              widget.icon,
            ),
          ),
        ),
      ),
    );
  }

  errorMessage(hint) {
    switch (hint) {
      case 'Email':
        return 'Please enter your email';
        break;
      case 'Name':
        return 'Please enter your name';
        break;
      case 'Password':
        return 'Please enter your password';
        break;
      default:
        break;
    }
  }
}
