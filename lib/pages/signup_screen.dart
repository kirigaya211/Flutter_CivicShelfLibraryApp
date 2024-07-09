// ignore_for_file: prefer_const_constructors

import 'package:civic_shelf_mobile_app/pages/home.dart';
import 'package:civic_shelf_mobile_app/widgets/reusable_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: Colors.orange),
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery.of(context).size.height * 0.2, 20, 0),
                child: Column(children: <Widget>[
                  reusableTextField("Enter Username", Icons.person_outline,
                      false, _usernameTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email Id", Icons.lock_clock_outlined,
                      false, _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_clock_outlined,
                      false, _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, false, () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text,
                            password: _passwordTextController.text)
                        .then((value) {
                      print("Created New Account");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Home(isLoggedIn:true)));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString}");
                    });
                  })
                ])),
          )),
    );
  }
}