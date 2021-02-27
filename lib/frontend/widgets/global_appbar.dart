import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/pages/user_pages/search.dart';

import 'gradient_widget.dart';

class GlobalAppBar extends PreferredSize {
  final IconData icon;
  final Function onClick;
  final String title;

  GlobalAppBar({this.icon, this.onClick, this.title});

  @override
  Size get preferredSize {
    return Size(double.infinity, kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GradientWidget(
        child: IconButton(
          splashColor: Theme.of(context).accentColor.withOpacity(0.3),
          icon: Icon(icon),
          onPressed: onClick,
        ),
      ),
      title: GradientWidget(
        child: Text(
          (title == null) ? mAppName : title,
          style: globalTextStyle,
        ),
      ),
      actions: [
        GradientWidget(
          child: IconButton(
            splashColor: Theme.of(context).accentColor.withOpacity(0.3),
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Search.routeName);
            },
          ),
        ),
      ],
    );
  }
}
