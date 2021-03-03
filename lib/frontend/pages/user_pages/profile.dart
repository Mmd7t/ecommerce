import 'package:ecommerce/backend/models/user.dart';
import 'package:ecommerce/backend/services/db_users.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/auth_provider.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/frontend/pages/registration/sign_btn.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final textProfileList = [
    'Language',
    'Address',
    'Orders',
  ];

  final iconProfileList = [
    Icons.language,
    Icons.notes,
    Icons.online_prediction_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UsersDB().getData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            Users user = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Profile Image  -------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        GradientBorder(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          radius: 100,
                          child: ClipOval(
                            child: (user.img == null)
                                ? Icon(Icons.camera_alt_outlined)
                                : Image.network(user.img),
                          ),
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
                                icon: const Icon(Icons.camera_alt_outlined,
                                    size: 15),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: -5,
                          child: GradientBorder(
                            radius: 60,
                            width: 35,
                            height: 35,
                            child: GradientWidget(
                              child: IconButton(
                                icon: const Icon(Icons.edit_outlined, size: 15),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Profile Name  --------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                    Text(
                      user.name,
                      style: globalTextStyle2.copyWith(
                        fontSize:
                            Theme.of(context).textTheme.headline5.fontSize,
                      ),
                    ),
                    const SizedBox(height: 30),
/*------------------------------------------------------------------------------------------------------*/
/*------------------------------------------  Profile List  --------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                    ListView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: GradientBorder(
                            radius: 50,
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    showDialoge(context, Text("data 0"));
                                    break;
                                  case 1:
                                    showDialoge(context, Text("data 1"));
                                    break;
                                  case 2:
                                    showDialoge(context, Text("data 2"));
                                    break;
                                  default:
                                    break;
                                }
                              },
                              title: Text(textProfileList[index]),
                              leading: GradientWidget(
                                child: Icon(iconProfileList[index]),
                              ),
                              trailing: GradientWidget(
                                child: Icon(Icons.arrow_forward_ios_rounded),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
/*------------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Logout Btn  ---------------------------------------------*/
/*------------------------------------------------------------------------------------------------------*/
                    SignBtn(
                      onClick: () => context.read<AuthProvider>().signOut(),
                      text: 'Logout',
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
