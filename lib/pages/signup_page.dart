import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego2/export_package.dart';
import 'package:herewego2/export_package.dart';

class SignUpPage extends StatefulWidget {
  static final String id = "signup_page";

  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _doSignUp() {
    String fullname = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    // if(fullname.isEmpty || email.isEmpty || password.isEmpty) return;

    // Firebase dan SIGNUP ni chaqirib olish
    setState(() {
      isLoading = true;
    });
    AuthService.signUpUser(context, fullname, email, password).then(
      (firebaseUser) => {
        _getFirebaseUser(firebaseUser!),
      },
    );
  }

  void _getFirebaseUser(User firebaseUser) async {
    setState(() {
      isLoading = false;
    });
    if (firebaseUser != null) {
      // Preferences dan saqlashni chaqirib olish
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Check your informations");
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
                controller: fullNameController,
                decoration: InputDecoration(
                  hintText: "FullName",
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(hintText: "Password"),
              ),
              SizedBox(height: 25),
              Container(
                height: 50,
                width: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    _doSignUp();
                  },
                  color: Colors.blue,
                  child: const Text(
                    "SignUp",
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
                      "Already have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignInPage.id);
                      },
                      child: const Text(
                        "Sign In",
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
        isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox.shrink(),
      ],
    ));
  }
}
