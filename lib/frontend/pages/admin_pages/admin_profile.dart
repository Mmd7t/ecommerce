import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/admin_provider.dart';
import 'package:ecommerce/backend/providers/auth_provider.dart';
import 'package:ecommerce/frontend/pages/registration/sign_btn.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

import '../../../constants.dart';

class AdminProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            /*----------------------------------  Profile Image  ------------------------------------*/
            Stack(
              clipBehavior: Clip.none,
              children: [
                GradientBorder(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  radius: 100,
                  child: const FlutterLogo(),
                ),
                Positioned(
                  bottom: 0,
                  right: -5,
                  child: GradientBorder(
                    radius: 60,
                    width: 35,
                    height: 35,
                    child: GradientWidget(
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          size: 15,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            /*----------------------------------  Profile Name  ------------------------------------*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Medhat Mostafa",
                  style: globalTextStyle2.copyWith(
                      fontSize: Theme.of(context).textTheme.headline5.fontSize),
                ),
                GradientWidget(
                  child: IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            /*----------------------------------  Profile List  ------------------------------------*/
            ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: GradientBorder(
                    radius: 50,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      onTap: () {
                        switch (index) {
                          case 0:
                            showDialoge(context, const Text("data 0"));
                            break;
                          case 1:
                            showDialoge(context, const Text("data 1"));
                            break;
                          case 2:
                            showDialoge(context, const Text("data 2"));
                            break;
                          default:
                            break;
                        }
                      },
                      title: const Text("list"),
                      leading: GradientWidget(
                        child: const Icon(Icons.person_outline_rounded),
                      ),
                      trailing: GradientWidget(
                        child: const Icon(Icons.arrow_forward_ios_rounded),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            /*----------------------------------  Logout Button  ------------------------------------*/
            SignBtn(
              onClick: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
                Provider.of<AdminProvider>(context, listen: false)
                    .switchAdmin();
              },
              text: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}
