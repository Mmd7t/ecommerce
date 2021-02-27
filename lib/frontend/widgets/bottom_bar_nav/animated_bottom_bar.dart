import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/frontend/pages/admin_pages/add_product.dart';
import 'package:ecommerce/frontend/pages/user_pages/cart_page.dart';

import '../gradient_border.dart';
import '../gradient_widget.dart';

class AnimatedBottomBar extends StatefulWidget {
  AnimatedBottomBar({
    this.barItems,
    this.animationDuration = const Duration(milliseconds: 500),
    this.onBarTap,
    this.barStyle,
    this.isAdminPage,
  });

  final Duration animationDuration;
  final List<BarItem> barItems;
  final BarStyle barStyle;
  final Function onBarTap;
  final bool isAdminPage;

  @override
  _AnimatedBottomBarState createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar>
    with TickerProviderStateMixin {
  int selectedBarIndex = 0;

  /*---------------------------  Function buildBarItems  -----------------------------*/

  List<Widget> _buildBarItems() {
    List<Widget> _barItems = List();
    for (int i = 0; i < widget.barItems.length; i++) {
      BarItem item = widget.barItems[i];
      bool isSelected = selectedBarIndex == i;
      _barItems.add(InkWell(
        splashColor: Colors.transparent,
        borderRadius: BorderRadius.circular(50),
        onTap: () {
          setState(() {
            selectedBarIndex = i;
            widget.onBarTap(selectedBarIndex);
          });
        },
        child: AnimatedContainer(
          padding: (isSelected)
              ? const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0)
              : const EdgeInsets.all(12.0),
          duration: widget.animationDuration,
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      Theme.of(context).accentColor,
                      Theme.of(context).primaryColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor,
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            children: <Widget>[
              isSelected
                  ? Icon(
                      item.iconData,
                      color: isSelected
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                      size: widget.barStyle.iconSize,
                    )
                  : GradientWidget(
                      child: Icon(
                        item.iconData,
                        color: isSelected
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        size: widget.barStyle.iconSize,
                      ),
                    ),
              SizedBox(
                width: (isSelected) ? 10.0 : 0.0,
              ),
              AnimatedSize(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                vsync: this,
                child: Text(
                  isSelected ? item.text : "",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: widget.barStyle.fontWeight,
                    fontSize: widget.barStyle.fontSize,
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    }
    return _barItems;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          (widget.isAdminPage)
              ? Container(
                  child: _animatedBottomBarBody(theme),
                  width: MediaQuery.of(context).size.width * 0.7,
                )
              : Expanded(
                  child: _animatedBottomBarBody(theme),
                ),
          SizedBox(
            width: 5,
          ),
          /*---------------------------------  Floating Btn  ---------------------------------*/
          Stack(
            children: [
              GradientBorder(
                child: GradientWidget(
                  child: IconButton(
                    icon: Icon((widget.isAdminPage)
                        ? Icons.add
                        : Icons.shopping_cart_outlined),
                    onPressed: (widget.isAdminPage)
                        ? () {
// ------------------------------->> GoTo Add Product Page
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddProduct(mode: 'add', data: null),
                              ),
                            );
                          }
                        : () {
                            Navigator.of(context).pushNamed(CartPage.routeName);
                          },
                  ),
                ),
                width: 50,
                height: 50,
                radius: 50,
              ),
              (widget.isAdminPage)
                  ? SizedBox()
                  : Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Text(""),
                        radius: 7.5,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  /*------------------------  Bottom Bar Body  ------------------------*/
  _animatedBottomBarBody(theme) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: (theme.theme) ? Colors.transparent : Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: (theme.theme)
                ? [
                    bottomNavColorDark,
                    bottomNavColorDark,
                  ]
                : [
                    Theme.of(context).accentColor.withOpacity(0.4),
                    Theme.of(context).primaryColor.withOpacity(0.4),
                  ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 5.0,
            top: 5.0,
            left: 6.0,
            right: 6.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildBarItems(),
          ),
        ),
      ),
    );
  }
}

/*---------------------------  Class BarStyle  -----------------------------*/

class BarStyle {
  BarStyle({this.fontSize, this.iconSize, this.fontWeight = FontWeight.w800});

  final FontWeight fontWeight;
  final double fontSize, iconSize;
}

/*---------------------------  Class BarItem  -----------------------------*/
class BarItem {
  BarItem({this.text, this.iconData});

  IconData iconData;
  String text;
}
