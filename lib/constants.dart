import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'frontend/widgets/gradient_border.dart';

const mAppName = 'WE commerce';

const bottomNavColorDark = Color(0xFF161616);

/*------------------------------  Shared Prefs Keys  --------------------------------*/
const String initialPage = 'initPage';
const String themeKey = 'theme';
const String adminKey = 'admin';

TextStyle globalTextStyle = GoogleFonts.oleoScript();
TextStyle globalTextStyle2 = GoogleFonts.zcoolXiaoWei();
TextStyle globalTextStyle3 = GoogleFonts.openSans();

showDialoge(context, child) {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: GradientBorder(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 50,
          radius: 20,
          child: child,
        ),
      );
    },
  );
}

toast(msg) {
  Fluttertoast.showToast(msg: msg);
}

const String productCollectionName = 'products';
const String userCollectionName = 'users';
const String cartCollectionName = 'cart';
