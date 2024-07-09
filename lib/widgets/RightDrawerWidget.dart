// ignore_for_file: sort_child_properties_last, prefer_const_constructors, use_super_parameters

import 'dart:io';

import 'package:civic_shelf_mobile_app/pages/home.dart';
import 'package:civic_shelf_mobile_app/pages/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ... (import statements)

class RightDrawerWidget extends StatelessWidget {
  final bool isloggedIn;

  const RightDrawerWidget({Key? key, required this.isloggedIn}) : super(key: key);

  static String url = "";
  static int? number;

  uploadDataToFirebase() async {
    // Pick pdf file
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String fileName = result.files.single.name; // Extract the file name
      File pick = File(result.files.single.path.toString());
      var file = pick.readAsBytesSync();

      // Uploading file to Firebase
      var pdfFile = FirebaseStorage.instance.ref().child(fileName).child("$fileName.pdf");
      UploadTask task = pdfFile.putData(file);
      TaskSnapshot snapshot = await task;
      url = await snapshot.ref.getDownloadURL();

      // Upload URL to Cloud Firebase
      await FirebaseFirestore.instance
          .collection("file")
          .doc()
          .set({'fileUrl': url, 'num': fileName});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.face,
              size: 128.0,
              color: Colors.white54,
            ),
            decoration: BoxDecoration(color: Colors.orange),
          ),
          Column(
            children: [
              Divider(),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings'),
              //   onTap: () {},
              // ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
                onTap: () {},
              ),
              if (!isloggedIn) // Show "Login" only if not logged in
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Login'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                ),
              if (isloggedIn)
                ListTile(
                  leading: Icon(Icons.upload),
                  title: Text('Upload'),
                  onTap: () {
                    uploadDataToFirebase();
                  },
                ),
              if (isloggedIn)
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home(isLoggedIn: false)),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
