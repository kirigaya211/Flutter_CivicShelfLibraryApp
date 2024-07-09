// ignore_for_file: prefer_const_constructors

import 'package:civic_shelf_mobile_app/pages/home.dart';
import 'package:civic_shelf_mobile_app/pages/signup_screen.dart';
import 'package:civic_shelf_mobile_app/widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(color: Colors.orange),
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(children: <Widget>[
                  //logoWidget("assets/images/logo.png"),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Enter Username", Icons.person_outline,
                      false, _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_clock_outlined,
                      true, _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, true, () {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Home(
                                isLoggedIn: true,
                              )));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
                  //signUpOption()
                ])),
          )),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
