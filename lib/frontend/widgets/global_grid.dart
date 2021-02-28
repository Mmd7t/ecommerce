import 'package:ecommerce/backend/models/cart.dart';
import 'package:ecommerce/backend/models/fav.dart';
import 'package:ecommerce/backend/models/product_with_attachs.dart';
import 'package:ecommerce/backend/providers/theme_provider.dart';
import 'package:ecommerce/backend/services/db_cart.dart';
import 'package:ecommerce/backend/services/db_fav.dart';
import 'package:ecommerce/backend/services/db_products.dart';
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
    // var product = Provider.of<List<Product>>(context);
    // var cart = Provider.of<CartProvider>(context);
    return StreamBuilder<List<ProductWithAttachs>>(
        stream: ProductsListWithAttachs().getProductsWithAttachs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final product = snapshot.data;
            if (product == null) {
              return Center(
                child: Text('Data is empty',
                    style: Theme.of(context).textTheme.headline6),
              );
            }

            return Padding(
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
                            arguments: product[index].product.id);
                      },
                      child: GridTile(
/*------------------------------------------------------------------------------*/
/*----------------------------------  Footer  ----------------------------------*/
/*------------------------------------------------------------------------------*/
                        footer: footer(
                          name: product[index].product.name,
                          context: context,
                          price: product[index].product.price,
                        ),
/*------------------------------------------------------------------------------*/
/*----------------------------------  Header  ----------------------------------*/
/*------------------------------------------------------------------------------*/
                        header: header(
                          context: context,
                          data: product[index],
                          image: product[index].product.img,
                        ),
/*------------------------------------------------------------------------------*/
/*----------------------------------  Child  -----------------------------------*/
/*------------------------------------------------------------------------------*/
                        child: child(
                            context: context,
                            img: product[index].product.img,
                            theme: theme.theme),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
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
  header({context, ProductWithAttachs data, image}) {
    // bool isAddedToCart = await CartDB().getDataById(data.id);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            (type == gridType.home)
                ? (data.isFav)
                    ? Icons.favorite
                    : Icons.favorite_border
                : Icons.remove_circle_outline_rounded,
            color: Theme.of(context).accentColor,
          ),
          onPressed: (type == gridType.home)
              ? () {
                  if (data.isFav) {
                    FavDB().deleteData(data.product.id).then(
                        (value) => toast('Product removed from wishlist'));
                  } else {
                    FavDB()
                        .saveData(Fav(productId: data.product.id, isFav: true))
                        .then((value) => toast('Product added to wishlist'));
                  }
                }
              : () {
                  ProductsDB().deleteData(data.product);
                  ProductsDB().deleteImage(
                    img: image,
                  );
                },
        ),
        IconButton(
          icon: Icon(
            (type == gridType.home)
                ? (data.isAddedToCart)
                    ? Icons.shopping_cart_outlined
                    : Icons.add_shopping_cart_rounded
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
                          AddProduct(mode: 'edit', data: data.product)));
                },
        ),
      ],
    );
  }

/*-----------------------------------------------------------------------------------*/
/*----------------------------  Add to Cart Function  -------------------------------*/
/*-----------------------------------------------------------------------------------*/
  void handleAddToCart(ProductWithAttachs data, context) async {
    if (data.isAddedToCart) {
      toast('Product Already added to cart');
    } else {
      CartDB()
          .saveData(Cart(
              quantity: 1.toString(),
              productId: data.product.id,
              isAddToCart: true))
          .then((value) => toast('Product added to cart'));
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
