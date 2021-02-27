import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/bottom_bar_nav/animated_bottom_bar.dart';
import 'package:ecommerce/frontend/widgets/global_appbar.dart';

import 'admin_dashboard.dart';
import 'admin_manage.dart';
import 'admin_profile.dart';

class AdminHome extends StatefulWidget {
  static final routeName = 'adminHome';
  final List<BarItem> barItems = [
    BarItem(
      text: "Dashboard",
      iconData: Icons.dashboard_outlined,
    ),
    BarItem(
      text: "Manage",
      iconData: Icons.format_paint_outlined,
    ),
    BarItem(
      text: "Profile",
      iconData: Icons.person_outline_rounded,
    ),
  ];

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  int selectedBarIndex = 0;
  final _pagesOptions = [
    AdminDashboard(),
    AdminManage(),
    AdminProfile(),
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
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBottomBar(
              isAdminPage: true,
              barItems: widget.barItems,
              animationDuration: const Duration(milliseconds: 200),
              barStyle: BarStyle(fontSize: 13.0, iconSize: 22.0),
              onBarTap: (index) {
                setState(() {
                  selectedBarIndex = index;
                });
              }),
        ],
      ),
    );
  }
}
