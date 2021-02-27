import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/frontend/widgets/bottom_bar_nav/animated_bottom_bar.dart';
import 'package:ecommerce/frontend/widgets/global_appbar.dart';

import 'categories.dart';
import 'home.dart';
import 'profile.dart';
import 'wishlist.dart';

class MainPage extends StatefulWidget {
  static final routeName = 'mainPage';

  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home_outlined,
    ),
    BarItem(
      text: "Categories",
      iconData: Icons.category_outlined,
    ),
    BarItem(
      text: "Wishlist",
      iconData: Icons.favorite_border_rounded,
    ),
    BarItem(
      text: "Profile",
      iconData: Icons.person_outlined,
    ),
  ];

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedBarIndex = 0;
  final _pagesOptions = [
    Home(),
    Categories(),
    Wishlist(),
    Profile(),
  ];
  bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      /*-----------------------------------  AppBar  -----------------------------------*/
      appBar: GlobalAppBar(
        icon: theme.theme ? FontAwesomeIcons.solidMoon : FontAwesomeIcons.moon,
        onClick: () {
          theme.switchTheme();
        },
      ),
      extendBody: true,
      body: _pagesOptions[selectedBarIndex],
      bottomNavigationBar: AnimatedBottomBar(
          isAdminPage: false,
          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 200),
          barStyle: BarStyle(fontSize: 13.0, iconSize: 22.0),
          onBarTap: (index) {
            setState(() {
              selectedBarIndex = index;
            });
          }),
    );
  }
}
