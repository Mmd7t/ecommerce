import 'package:ecommerce/backend/models/product_cart.dart';
import 'package:ecommerce/backend/models/cart.dart';
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

class CartPage extends StatelessWidget {
  static const String routeName = 'cartPage';

  String setTotalPrice(List<ProductCart> items) {
    int totalPrice = 0;
    items.forEach((item) {
      totalPrice = totalPrice +
          (int.parse(item.product.price) * int.parse(item.quantity));
    });
    return totalPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    return StreamBuilder<List<ProductCart>>(
        stream: CartDB().getProductsCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final cartProduct = snapshot.data;
            if (cartProduct == null) {
              return Scaffold(
                body: Center(
                  child: Text('Cart list is empty',
                      style: Theme.of(context).textTheme.headline6),
                ),
              );
            }
            print(cartProduct);
            return Scaffold(
              appBar: GlobalAppBar(
                icon: Icons.arrow_back_ios_rounded,
                onClick: () {
                  Navigator.of(context).pop();
                },
              ),
              body: ListView.builder(
                itemCount: cartProduct.length,
                itemBuilder: (context, index) {
                  print(cartProduct.length);
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        child: Text(''),
                                      ),
                                    ),
                                  ),
                                  Image.network(cartProduct[index].product.img),
                                ],
                              ),
/*---------------------------------------------------------------------------------*/
/*------------------------------------  Title  ------------------------------------*/
/*---------------------------------------------------------------------------------*/
                              title: Text(
                                cartProduct[index].product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
/*---------------------------------------------------------------------------------*/
/*---------------------------------  Description  ---------------------------------*/
/*---------------------------------------------------------------------------------*/
                              subtitle: Text(
                                cartProduct[index].product.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
/*---------------------------------------------------------------------------------*/
/*---------------------------------  Delete Btn  ----------------------------------*/
/*---------------------------------------------------------------------------------*/
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_sweep_outlined),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  CartDB().deleteData(
                                      cartProduct[index].product.id);
                                  // setState(() {
                                  //   updateListView();
                                  // });
                                },
                              ),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    ProductInfo.routeName,
                                    arguments: cartProduct[index].product.id);
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.share_outlined),
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {},
                                      ),
                                      // (cartList == null) ? CircularProgressIndicator():
                                      GradientContainer(
                                        radius: 80,
                                        width: 120,
                                        height: 40,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                                      productId:
                                                          cartProduct[index]
                                                              .product
                                                              .id,
                                                      quantity: (int.parse(
                                                                  cartProduct[
                                                                          index]
                                                                      .quantity) -
                                                              1)
                                                          .toString(),
                                                      isAddToCart: true,
                                                    ));
                                                  },
                                                ),
                                              ),
                                            ),
                                            Text(
                                              cartProduct[index].quantity,
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
                                                      productId:
                                                          cartProduct[index]
                                                              .product
                                                              .id,
                                                      quantity: (int.parse(
                                                                  cartProduct[
                                                                          index]
                                                                      .quantity) +
                                                              1)
                                                          .toString(),
                                                      isAddToCart: true,
                                                    ));
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${cartProduct[index].product.price} \$",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              extendBody: true,
              /*--------------------------  Bottom Nav Bar  --------------------------*/
              /**
               * This is for showing The Total price and the Submit Btn to submit the order
               * **/
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                          child: RichText(
                            text: TextSpan(
                              text: "Total : ",
                              children: [
                                TextSpan(
                                  text: "${setTotalPrice(cartProduct)} \$",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
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

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

//
// updateListView() {
//     Future<List<Product>> noteListFuture = CartDB().getProductsFromCart();
//     noteListFuture.then((value) {
//       setState(() {
//         this.productsListFromCart = value;
//         this.count = value.length;
//       });
//     });
// }
}
