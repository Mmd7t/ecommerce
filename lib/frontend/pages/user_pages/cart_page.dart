import 'package:ecommerce/backend/models/cart.dart';
import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/services/db_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/global_appbar.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_container.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

import '../../../constants.dart';
import 'product_info.dart';

class CartPage extends StatefulWidget {
  static const String routeName = 'cartPage';

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<String> setTotalPrice() async {
    int totalPrice = 0;
    List<Cart> items = await CartDB().getCartList();
    items.forEach((item) {
      totalPrice += (int.parse(item.price) * int.parse(item.quantity));
    });
    return totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: GlobalAppBar(
        icon: Icons.arrow_back_ios_rounded,
        onClick: () {
          Navigator.of(context).pop();
        },
      ),
      body: StreamBuilder(
          stream: CartDB().getProductsCart(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.data != null) {
                List<Product> products = snapshot.data;
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
/*---------------------------------------------------------------------------------------------*/
/*----------------------------------------  List Tile  ----------------------------------------*/
/*---------------------------------------------------------------------------------------------*/
                              ListTile(
/*---------------------------------------------------------------------------------*/
/*------------------------------------  Image  ------------------------------------*/
/*---------------------------------------------------------------------------------*/
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
                                      width:
                                          MediaQuery.of(context).size.width / 9,
                                      height:
                                          MediaQuery.of(context).size.width / 9,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: GradientBorder(
                                          opacity: 0.3,
                                          radius: 100,
                                          color: (theme.theme)
                                              ? bottomNavColorDark
                                              : Theme.of(context)
                                                  .scaffoldBackgroundColor,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              9,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              9,
                                          child: Text(''),
                                        ),
                                      ),
                                    ),
                                    Image.network(products[index].img),
                                  ],
                                ),
/*---------------------------------------------------------------------------------*/
/*------------------------------------  Title  ------------------------------------*/
/*---------------------------------------------------------------------------------*/
                                title: Text(
                                  products[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
/*---------------------------------------------------------------------------------*/
/*---------------------------------  Description  ---------------------------------*/
/*---------------------------------------------------------------------------------*/
                                subtitle: Text(
                                  products[index].description,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
/*---------------------------------------------------------------------------------*/
/*---------------------------------  Delete Btn  ----------------------------------*/
/*---------------------------------------------------------------------------------*/
                                trailing: StreamBuilder(
                                  stream:  CartDB().getData(),
                                  builder: (context, snapshot) {
                                    return IconButton(
                                      icon: const Icon(Icons.delete_sweep_outlined),
                                      color: Theme.of(context).primaryColor,
                                      onPressed: () {
                                        CartDB().deleteData(snapshot.data[index]);
                                        setState(() {
                                          CartDB().getProductsCart();
                                        });
                                      },
                                    );
                                  }
                                ),
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed(ProductInfo.routeName,arguments: products[index].id);
                                },
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GradientWidget(
                                      child: const Divider(
                                          indent: 30,
                                          endIndent: 30,
                                          thickness: 1),
                                    ),
/*---------------------------------------------------------------------------------*/
/*-------------------------------  Quantity Widget  -------------------------------*/
/*---------------------------------------------------------------------------------*/
                                    FutureBuilder(
                                        future: CartDB().getCartList(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return CircularProgressIndicator();
                                          } else {
                                            Cart cartData = snapshot.data[index];
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.share_outlined),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  onPressed: () {},
                                                ),
                                                GradientContainer(
                                                  radius: 80,
                                                  width: 120,
                                                  height: 40,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GradientBorder(
                                                        radius: 80,
                                                        width: 40,
                                                        height: 40,
                                                        child: GradientWidget(
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.remove,
                                                              size: 20,
                                                            ),
                                                            onPressed: () {
                                                              CartDB().updateData(Cart(
                                                                id: cartData.id,
                                                                price: cartData.price,
                                                                productId: cartData.productId,
                                                                quantity: (int.parse(cartData.quantity)-1).toString(),
                                                              ));
                                                              setState(() {
                                                                CartDB().getProductsCart();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        cartData.quantity,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1,
                                                      ),
                                                      GradientBorder(
                                                        radius: 80,
                                                        width: 40,
                                                        height: 40,
                                                        child: GradientWidget(
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons.add,
                                                              size: 20,
                                                            ),
                                                            onPressed: () {
                                                              CartDB().updateData(Cart(
                                                                id: cartData.id,
                                                                price: cartData.price,
                                                                productId: cartData.productId,
                                                                quantity: (int.parse(cartData.quantity)+1).toString(),
                                                              ));
                                                              setState(() {
                                                                CartDB().getProductsCart();
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  "${products[index].price} \$",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ],
                                            );
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('Not Data Found'));
              }
            }
          }),
      extendBody: true,
      /*--------------------------  Bottom Nav Bar  --------------------------*/
      /**
       * This is for showing The Total price and the Submit Btn to submit the order
       * **/
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: GradientBorder(
          radius: 60,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: FutureBuilder(
                      future: setTotalPrice(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          return RichText(
                            text: TextSpan(
                              text: "Total : ",
                              children: [
                                TextSpan(
                                  text: (snapshot.data != null)
                                      ? "${snapshot.data} \$"
                                      : '0 \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          );
                        }
                      }),
                ),
              ),
              Expanded(
                flex: 1,
                child: GradientContainer(
                  radius: 50,
                  child: Text(
                    "Submit Order",
                    style: globalTextStyle3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
