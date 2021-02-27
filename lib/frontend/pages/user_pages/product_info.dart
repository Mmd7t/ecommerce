import 'dart:async';

import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/services/db_products.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/global_appbar.dart';
import 'package:ecommerce/frontend/widgets/global_btn.dart';
import 'package:ecommerce/frontend/widgets/global_ink_well.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_container.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class ProductInfo extends StatefulWidget {
  static const String routeName = 'productInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo>
    with TickerProviderStateMixin {
  Animation animation, animation2;
  AnimationController animationController;
  double high;
  bool isClicked;
  Timer time;
  var productPrice = '';

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    time.cancel();
  }

  @override
  void initState() {
    super.initState();
    high = 50;
    isClicked = false;
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    time = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        if (timer.tick <= 5) {
          if (timer.tick == 1) {
            setState(() {
              high = 150;
              isClicked = true;
              animationController.forward();
            });
          } else if (timer.tick == 5) {
            setState(() {
              high = 50;
              isClicked = false;
              animationController.reverse();
            });
          }
        } else {
          timer.cancel();
        }
      },
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animation2 = Tween(begin: 1.0, end: 0.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    var productId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: GlobalAppBar(
        icon: Icons.arrow_back_ios_rounded,
        onClick: () {
          Navigator.of(context).pop();
        },
      ),
      extendBody: true,
      body: FutureBuilder(
          future: ProductsDB().getDataById(productId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Product product = snapshot.data;
              productPrice = product.price;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GradientContainer(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.network(product.img),
                        ),
                        radius: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          IconButton(
                            splashColor: Theme.of(context).accentColor,
                            splashRadius: 25,
                            icon: Icon(
                              Icons.favorite_border,
                              size: 30,
                              color: Theme.of(context).accentColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        product.description,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _priceWidget(),
            /*----------------------------------  Add to Cart  ------------------------------------*/
            GlobalBtn(
              text: "Add to Cart",
              onClick: () {},
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
            ),
          ],
        ),
      ),
    );
  }

  //--**
  /*----------------------------------  Price Widget  ------------------------------------*/
  //--**
  _priceWidget() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        GradientContainer(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          width: high,
          height: 50,
          radius: 50,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 600),
            opacity: animation2.value,
            child: Text(
              productPrice,
              style: globalTextStyle2.copyWith(
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        GlobalSplash(
          radius: 50,
          onPressed: () {
            if (!isClicked) {
              setState(() {
                high = 150;
                isClicked = true;
                animationController.forward();
              });
            } else {
              setState(() {
                high = 50;
                isClicked = false;
                animationController.reverse();
              });
            }
          },
          child: RotationTransition(
            turns: animation,
            alignment: Alignment.center,
            child: GradientBorder(
              child: GradientWidget(
                child: Text(
                  "\$",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              width: 50,
              height: 50,
              radius: 50,
            ),
          ),
        ),
      ],
    );
  } //PriceWidget

}
