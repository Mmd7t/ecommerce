import 'package:ecommerce/backend/models/cart.dart';
import 'package:ecommerce/backend/models/product.dart';
// import 'package:ecommerce/backend/providers/cart_provider.dart';
import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:ecommerce/backend/services/db_cart.dart';
import 'package:ecommerce/backend/services/db_products.dart';
import 'package:ecommerce/backend/services/db_users.dart';
import 'package:ecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/frontend/pages/admin_pages/add_product.dart';
import 'package:ecommerce/frontend/pages/user_pages/product_info.dart';

import 'gradient_border.dart';
import 'gradient_container.dart';

enum gridType { home, admin }

class GlobalGrid extends StatelessWidget {
  final gridType type;

  const GlobalGrid({this.type = gridType.home});

  const GlobalGrid.admin({this.type = gridType.admin});

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProvider>(context);
    var product = Provider.of<List<Product>>(context);
    // var cart = Provider.of<CartProvider>(context);
    return (product == null)
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: product.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProductInfo.routeName,
                          arguments: product[index].id);
                    },
                    child: GridTile(
/*------------------------------------------------------------------------------*/
/*----------------------------------  Footer  ----------------------------------*/
/*------------------------------------------------------------------------------*/
                      footer: footer(
                        name: product[index].name,
                        context: context,
                        price: product[index].price,
                      ),
/*------------------------------------------------------------------------------*/
/*----------------------------------  Header  ----------------------------------*/
/*------------------------------------------------------------------------------*/
                      header: header(
                        context: context,
                        data: product[index],
                        image: product[index].img,
                      ),
/*------------------------------------------------------------------------------*/
/*----------------------------------  Child  -----------------------------------*/
/*------------------------------------------------------------------------------*/
                      child: child(
                          context: context,
                          img: product[index].img,
                          theme: theme.theme),
                    ),
                  ),
                );
              },
            ),
          );
  }

/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Footer Function  ------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  footer({name, context, price}) {
    return GradientContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '$price \$',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
      radius: 0,
      height: 45,
    );
  }

/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Header Function  ------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  header({context, data, image}) {
    // bool isAddedToCart = await CartDB().getDataById(data.id);
    return FutureBuilder(
      future: CartDB().getDataById(data.id),
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                (type == gridType.home)
                    ? Icons.favorite_border
                    : Icons.remove_circle_outline_rounded,
                color: Theme.of(context).accentColor,
              ),
              onPressed: (type == gridType.home)
                  ? () {}
                  : () {
                      ProductsDB().deleteData(data);
                      ProductsDB().deleteImage(
                        img: image,
                      );
                    },
            ),
            IconButton(
              icon: Icon(
                (type == gridType.home)
                    ? (snapshot.data == false || snapshot.data == null)? Icons.add_shopping_cart_rounded : Icons.shopping_cart_outlined
                    : Icons.edit_outlined,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (type == gridType.home)
                  ? () {
                      handleAddToCart(data, context);
                    }
                  : () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              AddProduct(mode: 'edit', data: data)));
                    },
            ),
          ],
        );
      }
    );
  }

/*-----------------------------------------------------------------------------------*/
/*----------------------------  Add to Cart Function  -------------------------------*/
/*-----------------------------------------------------------------------------------*/
  void handleAddToCart(data, context) async {
    bool isAddedToCart = await CartDB().getDataById(data.id);
    // var cart = Provider.of<CartProvider>(context, listen: false);
    // await cart.getDataById(data.id);
    if (isAddedToCart == false || isAddedToCart == null) {
      CartDB()
              .saveData(Cart(
            id: CartDB().getId(),
            productId: data.id,
            quantity: 1.toString(),
            price: data.price,
          ))
              .then((value) => toast('Product added to cart'));
    }  else{
      toast('Product already added to cart');
    }
  }

/*-----------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Child Function  -------------------------------------------*/
/*-----------------------------------------------------------------------------------------------------*/
  child({context, theme, img}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 2.0,
            offset: Offset(0, 1),
            color: Colors.black12,
          )
        ],
        color: (theme) ? bottomNavColorDark : Colors.white,
        border: (theme)
            ? Border.fromBorderSide(BorderSide.none)
            : Border.all(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                width: 2,
              ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GradientBorder(
            opacity: 0.3,
            padding: 3,
            color: (theme)
                ? bottomNavColorDark
                : Theme.of(context).scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GradientBorder(
                child: Text(''),
                radius: 50,
                padding: 3,
                color: (theme)
                    ? bottomNavColorDark
                    : Theme.of(context).scaffoldBackgroundColor,
                opacity: 0.3,
              ),
            ),
            radius: 50,
            width: 70,
            height: 70,
          ),
          Image.network(
            img,
            height: 100,
          ),
        ],
      ),
    );
  }
}
