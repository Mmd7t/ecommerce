import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/backend/providers/admin_provider.dart';
import 'package:ecommerce/backend/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/frontend/widgets/global_logo.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

import 'bottom_sign_text.dart';
import 'custom_textfield.dart';
import 'sign_btn.dart';
import 'social_sign_btn.dart';

enum AuthMode { signUp, login }

class Registration extends StatefulWidget {
  static final routeName = 'registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String name, email, pass;

  var formKey = GlobalKey<FormState>();

  AuthMode authMode = AuthMode.signUp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: GlobalLogo(
                    size: Theme.of(context).textTheme.headline4.fontSize,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
/*--------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Name TextField  ----------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
                      (authMode == AuthMode.signUp)
                          ? CustomTextField(
                              hint: 'Name',
                              inputAction: TextInputAction.next,
                              kType: TextInputType.name,
                              icon: Icons.person_outline_rounded,
                              onSave: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                              validator: (String value) {
                                return null;
                              },
                            )
                          : SizedBox(),
                      const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Email TextField  ---------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
                      CustomTextField(
                        hint: 'Email',
                        kType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        icon: Icons.email_outlined,
                        onSave: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (String value) {
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                        },
                      ),
                      const SizedBox(height: 10),
/*--------------------------------------------------------------------------------------------------*/
/*--------------------------------------  Password TextField  --------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
                      CustomTextField(
                        obscure: true,
                        hint: 'Password',
                        kType: TextInputType.visiblePassword,
                        inputAction: TextInputAction.done,
                        icon: Icons.lock_outline_rounded,
                        showPassIcon: Icons.remove_red_eye,
                        onSave: (value) {
                          setState(() {
                            pass = value;
                          });
                        },
                        validator: (String value) {
                          if (value.length < 6) {
                            return 'Password must not be less than 6 digits';
                          }
                        },
                      ),
                      const SizedBox(height: 30),
/*--------------------------------------------------------------------------------------------------*/
/*-------------------------------------------  Sign Btn  -------------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
                      SignBtn(
                          text: (authMode == AuthMode.signUp)
                              ? 'Sign up'
                              : 'Login',
                          onClick: () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              if (authMode == AuthMode.signUp) {
                                context
                                    .read<AuthProvider>()
                                    .signUp(name, email.trim(), pass, context);
                              } else {
                                if (email == 'admin@admin.com' &&
                                    pass == 'admin1234') {
                                  Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .switchAdmin();
                                }
                                context
                                    .read<AuthProvider>()
                                    .signIn(email.trim(), pass, context);
                              }
                            }
                          }),
                      const SizedBox(height: 25),
                      _divider(),
                      const SizedBox(height: 25),
/*--------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Social Sign Btn  ---------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialSignBtn(
                            icon: FontAwesomeIcons.facebookF,
                            color: Colors.blue,
                            onClick: () => context
                                .read<AuthProvider>()
                                .connectWithFacebook(),
                          ),
                          SocialSignBtn(
                            icon: FontAwesomeIcons.google,
                            color: Colors.redAccent,
                            onClick: () => context
                                .read<AuthProvider>()
                                .connectWithGoogle(),
                          ),
                          SocialSignBtn(
                            icon: FontAwesomeIcons.twitter,
                            color: Colors.lightBlueAccent,
                            onClick: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
/*--------------------------------------------------------------------------------------------------*/
/*---------------------------------------  Switch Sign Text  ---------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
                      BottomSignText(
                        onClick: (authMode == AuthMode.signUp)
                            ? () {
                                setState(() {
                                  authMode = AuthMode.login;
                                });
                              }
                            : () {
                                setState(() {
                                  authMode = AuthMode.signUp;
                                });
                              },
                        text1: (authMode == AuthMode.signUp)
                            ? 'Already have an account ?! '
                            : 'Don\'t have an account ?! ',
                        text2: (authMode == AuthMode.signUp)
                            ? 'Sign in'
                            : 'Sign up',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*--------------------------------------------------------------------------------------------------*/
/*----------------------------------------  Divider Func.  -----------------------------------------*/
/*--------------------------------------------------------------------------------------------------*/
  _divider() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: 25,
            endIndent: 20,
            thickness: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
        GradientWidget(
          child: Text("OR CONNECT WITH"),
        ),
        Expanded(
          child: Divider(
            indent: 20,
            endIndent: 25,
            thickness: 1,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
