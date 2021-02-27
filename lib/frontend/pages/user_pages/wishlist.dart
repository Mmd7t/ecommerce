import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ecommerce/frontend/pages/user_pages/product_info.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          /*-------------------------------  Slidable  -------------------------------*/
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            movementDuration: Duration(milliseconds: 200),
            actionExtentRatio: 0.20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: GradientBorder(
                color: (theme.theme)
                    ? bottomNavColorDark
                    : Theme.of(context).scaffoldBackgroundColor,
                radius: 20,
                opacity: 0.6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    /*---------------------  Leading  ---------------------*/
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        GradientBorder(
                          radius: 100,
                          opacity: 0.3,
                          color: (theme.theme)
                              ? bottomNavColorDark
                              : Theme.of(context).scaffoldBackgroundColor,
                          width: MediaQuery.of(context).size.width / 9,
                          height: MediaQuery.of(context).size.width / 9,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GradientBorder(
                              opacity: 0.3,
                              radius: 100,
                              color: (theme.theme)
                                  ? bottomNavColorDark
                                  : Theme.of(context).scaffoldBackgroundColor,
                              width: MediaQuery.of(context).size.width / 9,
                              height: MediaQuery.of(context).size.width / 9,
                              child: Text(''),
                            ),
                          ),
                        ),
                        Image.asset('assets/hummar.png'),
                      ],
                    ),
                    /*---------------------  Title  ---------------------*/
                    title: Text(
                      "Jack Hammer",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    /*---------------------  SubTitle  ---------------------*/
                    subtitle: Text(
                      "Not for sale yakhoyaaaa",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    /*---------------------  Trailling  ---------------------*/
                    trailing: IconButton(
                      icon: Icon(Icons.share_outlined),
                      color: Theme.of(context).primaryColor,
                      onPressed: () {},
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductInfo.routeName);
                    },
                  ),
                ),
              ),
            ),
            /*-------------------------------  Cart IconButton  -------------------------------*/
            actions: <Widget>[
              actionButton(
                context,
                icon: Icons.add_shopping_cart_rounded,
                onClick: () {
                  print("cart");
                },
              ),
            ],
            /*-------------------------------  Favorite IconButton  -------------------------------*/
            secondaryActions: <Widget>[
              actionButton(
                context,
                icon: Icons.favorite_outline,
                onClick: () {
                  print("fav");
                },
              ),
            ],
          );
        },
      ),
    );
  }

  /*-------------------------------  ActionButton  -------------------------------*/
  actionButton(BuildContext context, {IconData icon, Function onClick}) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: IconSlideAction(
        iconWidget: GradientBorder(
          radius: 50,
          width: MediaQuery.of(context).size.width / 8,
          height: MediaQuery.of(context).size.width / 8,
          child: GradientWidget(
            child: IconButton(
              icon: Icon(icon),
              onPressed: onClick,
            ),
          ),
        ),
        onTap: () {},
        color: Colors.transparent,
      ),
    );
  }
}
