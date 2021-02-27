import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/global_grid.dart';

class AdminManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: GlobalGrid.admin());
  }
}
