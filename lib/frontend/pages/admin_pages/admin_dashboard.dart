import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_container.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          childAspectRatio: 1,
        ),
        itemCount: dashboard.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: GradientContainer(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              radius: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientBorder(
                    width: 50,
                    height: 50,
                    radius: 80,
                    child: GradientWidget(
                      child: Icon(Icons.category_outlined),
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

List<String> dashboard = [
  'Products',
  'Users',
  'Orders',
  'Salary',
  'Salary',
];
