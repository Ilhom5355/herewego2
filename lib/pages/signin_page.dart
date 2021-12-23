import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego2/export_package.dart';

class SignInPage extends StatefulWidget {
  static final String id = "signin_page";


  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false;

  _doSignIn() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if (email.isEmpty || password.isEmpty) return;

    setState(() {
      isLoading = true;
    });
    AuthService.signInUser(context, email, password).then((firebaseUser) =>
    {
      //bu pastdagi funksiya
      _getFireBaseUser(firebaseUser!),
    });
  }

  // _getFireBaseUser(FirebaseUser firebaseUser) async {
  _getFireBaseUser(User firebaseUser) async {
    setState(() {
      isLoading = false;
    });
    if (firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Check your email or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
      Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              hintText: "Password",
            ),
          ),
          SizedBox(height: 25),
          Container(
            child: FlatButton(
              height: 50,
              minWidth: double.infinity,
              color: Colors.blue,
              onPressed: () {
                _doSignIn();
              },
              child: const Text(
                "SignIn",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "Don`t have an account?",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, SignUpPage.id);
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    isLoading ?
    Center(child: CircularProgressIndicator(),): SizedBox.shrink(),
    ],
    )
    );
  }
}
