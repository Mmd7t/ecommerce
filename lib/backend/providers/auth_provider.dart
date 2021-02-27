import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce/backend/models/user.dart';
import 'package:ecommerce/backend/services/db_users.dart';
import 'package:ecommerce/constants.dart';

abstract class Auth {
  signUp(name, email, pass, context);

  signIn(email, pass, context);

  connectWithGoogle();

  connectWithFacebook();

  connectWithTwitter();

  signOut();
}

class AuthProvider implements Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  FacebookLogin facebookLogin = FacebookLogin();
  UsersDB _usersDB = UsersDB();

/*----------------------------------------------------------------------------------------*/
/*------------------------------------  Get User ID  -------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  getUID() {
    return _auth.currentUser.uid;
  }

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign Up  ---------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  signUp(name, email, pass, context) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      await _usersDB.saveData(Users(id: getUID(), name: name, email: email));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          showDialoge(context, Text("email-already-in-use"));
          break;
        case 'operation-not-allowed':
          showDialoge(context, Text("operation-not-allowed"));
          break;
        case 'invalid-email':
          showDialoge(context, Text("invalid email"));
          break;
        case 'weak-password':
          showDialoge(context, Text("weak-password"));
          break;
        default:
          break;
      }
    } catch (e) {
      print(e);
    }
  }

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign in  ---------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  signIn(email, pass, context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: pass);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          showDialoge(context, Text("User not found"));
          break;
        case 'wrong-password':
          showDialoge(context, Text("Wrong Password"));
          break;
        case 'invalid-email':
          showDialoge(context, Text("invalid email"));
          break;
        case 'user-disabled':
          showDialoge(context, Text("user disabled"));
          break;
        default:
          break;
      }
    } catch (e) {
      print(e);
    }
  }

/*----------------------------------------------------------------------------------------*/
/*-------------------------------  Connect With Facebook  --------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  connectWithFacebook() async {
    facebookLogin.logIn(['email']).then((value) {
      if (value.status == FacebookLoginStatus.loggedIn) {
        final FacebookAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(value.accessToken.token);
        return _auth.signInWithCredential(facebookAuthCredential);
      } else if (value.status == FacebookLoginStatus.error) {
        print('errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      }
    }).catchError((e) => print(e));
  }

/*----------------------------------------------------------------------------------------*/
/*--------------------------------  Connect With Google  ---------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  connectWithGoogle() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await _auth.signInWithCredential(credential);
    await _usersDB.saveData(Users(
        id: getUID(),
        name: googleUser.displayName,
        email: googleUser.email,
        img: googleUser.photoUrl));
  }

/*----------------------------------------------------------------------------------------*/
/*--------------------------------  Connect With Twitter  --------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  connectWithTwitter() {
    // TODO: implement signInWithTwitter
    throw UnimplementedError();
  }

/*----------------------------------------------------------------------------------------*/
/*------------------------------------  Auth State  --------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  Stream<User> get authStateChanges => _auth.authStateChanges();

/*----------------------------------------------------------------------------------------*/
/*--------------------------------------  Sign out  --------------------------------------*/
/*----------------------------------------------------------------------------------------*/
  @override
  signOut() async {
    try {
      for (var userInfo in _auth.currentUser.providerData) {
        switch (userInfo.providerId) {
          case 'google.com':
            await googleSignIn.signOut();
            break;
          case 'facebook.com':
            await facebookLogin.logOut();
            break;
          default:
            break;
        }
      }
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
