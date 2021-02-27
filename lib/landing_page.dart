import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'backend/providers/admin_provider.dart';
import 'frontend/pages/admin_pages/admin_home.dart';
import 'frontend/pages/registration/registration.dart';
import 'frontend/pages/user_pages/main_page.dart';

class LandingPage extends StatelessWidget {
  static const String routeName = 'landingPage';
  @override
  Widget build(BuildContext context) {
    var isAdmin = Provider.of<AdminProvider>(context);
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      if (isAdmin.admin) {
        return AdminHome();
      }
      return MainPage();
    }
    return Registration();
  }
}
