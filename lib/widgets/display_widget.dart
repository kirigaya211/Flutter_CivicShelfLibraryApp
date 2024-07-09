// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables, unused_import

import 'package:civic_shelf_mobile_app/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:civic_shelf_mobile_app/widgets/download_widget.dart';

class DisplayWidget extends StatelessWidget {
  const DisplayWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("file").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) =>
                        buildSheet(context, x['fileUrl'], x["num"]),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.book_rounded,
                      size: 48.0,
                      color: Colors.deepOrangeAccent.shade200,
                    ),
                    Divider(),
                    Expanded(
                      child: Text(
                        x["num"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget buildSheet(BuildContext context, String urls, String title) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 0.9,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            padding: EdgeInsets.all(16.0),
            child: ListView(
              controller: controller,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 7),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.center,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    FileList.addNewFile(title, urls);
                  },
                  icon: Icon(Icons.download),
                  label: Text('Download'),
                  style: ElevatedButton.styleFrom(
                    primary:
                        Colors.orange, // Set the background color of the button
                    onPrimary:
                        Color.fromRGBO(124, 0, 0, 1), // Set the text color
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0), // Adjust size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the border radius
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SingleChildScrollView(child: View(url: urls))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class View extends StatelessWidget {
  final String url;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  View({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800.0, // Set a fixed height or adjust as needed
      child: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}
