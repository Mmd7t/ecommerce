import 'package:ecommerce/backend/models/cart.dart';
import 'package:ecommerce/backend/models/product_fav.dart';
import 'package:ecommerce/backend/services/db_cart.dart';
import 'package:ecommerce/backend/services/db_fav.dart';
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
      child: StreamBuilder<List<ProductFav>>(
          stream: FavDB().getProductsFav(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final favProduct = snapshot.data;
              if (favProduct == null) {
                return Scaffold(
                  body: Center(
                    child: Text('Wish list is empty',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                );
              }
              print(favProduct);
              //here
              return ListView.builder(
                itemCount: favProduct.length,
                itemBuilder: (context, index) {
                  /*-------------------------------  Slidable  -------------------------------*/
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    movementDuration: Duration(milliseconds: 200),
                    actionExtentRatio: 0.20,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 5),
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
                                      : Theme.of(context)
                                          .scaffoldBackgroundColor,
                                  width: MediaQuery.of(context).size.width / 9,
                                  height: MediaQuery.of(context).size.width / 9,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GradientBorder(
                                      opacity: 0.3,
                                      radius: 100,
                                      color: (theme.theme)
                                          ? bottomNavColorDark
                                          : Theme.of(context)
                                              .scaffoldBackgroundColor,
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      child: Text(''),
                                    ),
                                  ),
                                ),
                                Image.network(favProduct[index].product.img),
                              ],
                            ),
                            /*---------------------  Title  ---------------------*/
                            title: Text(
                              favProduct[index].product.name,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            /*---------------------  SubTitle  ---------------------*/
                            subtitle: Text(
                              favProduct[index].product.description,
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
                              Navigator.of(context).pushNamed(
                                  ProductInfo.routeName,
                                  arguments: favProduct[index].product.id);
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
                          CartDB().saveData(Cart(
                              isAddToCart: true,
                              productId: favProduct[index].product.id,
                              quantity: 1.toString()));
                        },
                      ),
                    ],
                    /*-------------------------------  Favorite IconButton  -------------------------------*/
                    secondaryActions: <Widget>[
                      actionButton(
                        context,
                        icon: Icons.remove_circle_outline,
                        onClick: () {
                          FavDB().deleteData(favProduct[index].product.id);
                        },
                      ),
                    ],
                  );
                },
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
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
