import 'package:ecommerce/frontend/widgets/global_btn.dart';
import 'package:ecommerce/frontend/widgets/global_indicators.dart';
import 'package:ecommerce/landing_page.dart';
import 'package:flutter/material.dart';

import 'onboardingpage.dart';

class OnBoarding extends StatefulWidget {
  static final routeName = 'onBoarding';
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController pController;

  List<Widget> onBoardingPages = [
    OnBoardingPage(text: "Explore Products"),
    OnBoardingPage(text: "Make Payment"),
    OnBoardingPage(text: "Dark Theme"),
    OnBoardingPage(text: "Enjoy Shopping !!"),
  ];

  var currentPage = 0;
  @override
  void initState() {
    pController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
              controller: pController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: onBoardingPages),
          Positioned(
            bottom: 15,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GlobalIndicators(
                    length: onBoardingPages.length,
                    currentIndex: currentPage,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  GlobalBtn(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.5,
                    text: (currentPage == onBoardingPages.length - 1)
                        ? "Get started"
                        : "next",
                    onClick: () {
                      if (currentPage < 4 && currentPage >= 0) {
                        setState(() {
                          pController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                        });
                      }
                      if (currentPage == 3) {
                        Navigator.of(context)
                            .pushReplacementNamed(LandingPage.routeName);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
