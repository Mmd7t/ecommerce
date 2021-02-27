// import 'package:ecommerce/backend/providers/cart_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/landing_page.dart';
import 'backend/models/product.dart';
import 'backend/providers/admin_provider.dart';
import 'backend/providers/auth_provider.dart';
import 'backend/providers/theme_provider.dart';
import 'backend/services/db_products.dart';
import 'constants.dart';
import 'frontend/pages/admin_pages/add_product.dart';
import 'frontend/pages/admin_pages/admin_home.dart';
import 'frontend/pages/onboarding/onboarding.dart';
import 'frontend/pages/registration/registration.dart';
import 'frontend/pages/splash_screen.dart';
import 'frontend/pages/user_pages/cart_page.dart';
import 'frontend/pages/user_pages/main_page.dart';
import 'frontend/pages/user_pages/product_info.dart';
import 'frontend/pages/user_pages/search.dart';
import 'theme.dart';

/*-------------------------------------  Main Function  --------------------------------------*/

int initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.get(initialPage);
  prefs.setInt(initialPage, 1);
  await Firebase.initializeApp();
  runApp(MyApp());
}

/*-------------------------------------  My App Widget  --------------------------------------*/
//--**
//This widget used to control the whole app
//--**
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //--**
    //This widget used to Manage the Providers in my app
    //--**
    return MultiProvider(
      providers: [
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------------  Theme Provider  --------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------------  Admin Provider  --------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        ChangeNotifierProvider(create: (context) => AdminProvider()),
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------------  Auth Provider  ---------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        Provider(create: (context) => AuthProvider()),
/*----------------------------------------------------------------------------------------------*/
/*-----------------------------------  Auth State Provider  ------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider(
            create: (context) => context.read<AuthProvider>().authStateChanges),
/*----------------------------------------------------------------------------------------------*/
/*-------------------------------------  Products Provider  ------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        StreamProvider<List<Product>>(
            create: (context) => ProductsDB().getData()),
/*----------------------------------------------------------------------------------------------*/
/*--------------------------------------  Cart Provider  ---------------------------------------*/
/*----------------------------------------------------------------------------------------------*/
        // ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      builder: (context, child) => child,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          //--**
          // this widget used to manage the overlay of the app ethier top bar
          // or the bottom part that used to navigate in android
          //--**
          SystemChrome.setSystemUIOverlayStyle((value.theme)
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light);
          return MaterialApp(
            title: mAppName,
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            //--**
            // the manage the theme ethier dark or light theme
            //--**
            themeMode: value.theme ? ThemeMode.dark : ThemeMode.light,
            //--**
            // the main route in the app
            // this route is the first page in the app
            //--**
            home: SplashScreen(initScreen: initScreen),
            //--**
            // All routes that used in the app
            // it's used to manage the navigation between pages
            //--**
            routes: {
              /*----------------------  User Routes  ----------------------*/
              LandingPage.routeName: (context) => LandingPage(),
              Registration.routeName: (context) => Registration(),
              MainPage.routeName: (context) => MainPage(),
              ProductInfo.routeName: (context) => ProductInfo(),
              OnBoarding.routeName: (context) => OnBoarding(),
              CartPage.routeName: (context) => CartPage(),
              SplashScreen.routeName: (context) => SplashScreen(),
              Search.routeName: (context) => Search(),
              /*----------------------  Admin Routes  ----------------------*/
              AdminHome.routeName: (context) => AdminHome(),
              AddProduct.routeName: (context) => AddProduct(),
            },
          );
        },
      ),
    );
  }
}
