import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego2/pages/signin_page.dart';
import 'package:herewego2/services/prefs_service.dart';

// Xammasi Firebase

// class AuthService {
//   static final _auth = FirebaseAuth.instance;
//
//   // SIGNIN
//   static Future<FirebaseUser> signInUser(
//       BuildContext context, String email, String password) async {
//     try {
//       _auth.signInWithEmailAndPassword(email: email, password: password);
//       final FirebaseUser user = await _auth.currentUser();
//       print(user.toString());
//       return user;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
//
//   // SIGNUP
//   static Future<FirebaseUser> signUpUser(
//       BuildContext context, String fullname, String email, String password) async {
//     try {
//      var authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       FirebaseUser user = authResult.user;
//       print(user.toString());
//       return user;
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }
//
//   // SIGNOUT
//   static void signOutUser(BuildContext context){
//     _auth.signOut();
//     Prefs.removeUserId().then((value) {
//       Navigator.pushReplacementNamed(context, SignInPage.id);
//     });
//   }
// }




class AuthService {

  static final _auth = FirebaseAuth.instance;

  static Future<User?> signInUser(BuildContext context, String email, String
  password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = await _auth.currentUser;
      print(user.toString());
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<User?> signUpUser(BuildContext context, String name,
      String email, String password) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      print(user.toString());
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  static void signOutUser(BuildContext context) {
    _auth.signOut();
    Prefs.removeUserId().then((value) =>
    {
      Navigator.pushReplacementNamed(context, SignInPage.id),
    });
  }

}