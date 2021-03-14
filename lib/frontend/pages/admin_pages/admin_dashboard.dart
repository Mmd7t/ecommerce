import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_container.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDashboard extends StatelessWidget {
  static const List<String> dashboard = [
    'Products',
    'Users',
    'Orders',
    'Salary',
  ];

  static const List<IconData> dashboardIcons = [
    Icons.category_outlined,
    Icons.group_outlined,
    FontAwesomeIcons.firstOrderAlt,
    Icons.attach_money_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 3.6 / 4,
        ),
        itemCount: dashboard.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: GradientContainer(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0)
                      .copyWith(top: 15.0),
              radius: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientBorder(
                    width: 50,
                    height: 50,
                    radius: 80,
                    child: GradientWidget(
                      child: Icon(dashboardIcons[index]),
                    ),
                  ),
                  Text(
                    "751",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  GradientBorder(
                    height: 50,
                    radius: 13,
                    child: GradientWidget(
                      child: Text(
                        dashboard[index],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
