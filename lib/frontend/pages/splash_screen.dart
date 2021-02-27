import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/global_logo.dart';

import '../../landing_page.dart';
import 'onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  static final routeName = 'splash';
  final initScreen;

  const SplashScreen({Key key, this.initScreen}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacementNamed(
          (widget.initScreen == 0 || widget.initScreen == null)
              ? OnBoarding.routeName
              : LandingPage.routeName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GlobalLogo(
          size: Theme.of(context).textTheme.headline3.fontSize,
        ),
      ),
    );
  }
}
