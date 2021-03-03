import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ecommerce/frontend/widgets/gradient_container.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
      duration: Duration(milliseconds: 500),
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        crossAxisCount: 4,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return GradientContainer(
            radius: 20,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text('$index'),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 3 : 2.5),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
