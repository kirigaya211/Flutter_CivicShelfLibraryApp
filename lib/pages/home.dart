// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:civic_shelf_mobile_app/widgets/RightDrawerWidget.dart';
import 'package:civic_shelf_mobile_app/widgets/display_widget.dart';
import 'package:civic_shelf_mobile_app/widgets/download_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Home extends StatefulWidget {
  final bool isLoggedIn;
  const Home({super.key, required this.isLoggedIn});

  @override
  State<Home> createState() => _home1State();
}

class _home1State extends State<Home> {
  Widget _currentWidget = DisplayWidget();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Civic Shelf',
          style: TextStyle(
              color: Color.fromRGBO(124, 0, 0, 1), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
      ),
      endDrawer: RightDrawerWidget(isloggedIn: widget.isLoggedIn),
      body: SafeArea(
        child: _currentWidget,
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.orange,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentWidget = DisplayWidget();
                    });
                  },
                  icon: Icon(
                    Icons.home,
                    color: Color.fromRGBO(124, 0, 0, 1),
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _currentWidget = FileList();
                    });
                  },
                  icon: Icon(
                    Icons.my_library_books,
                    color: Color.fromRGBO(124, 0, 0, 1),
                  )),
              // IconButton(
              //     onPressed: () {
              //       setState(() {
              //         //_currentWidget = NotificationWidget();
              //       });
              //     },
              //     icon: Icon(
              //       Icons.notifications,
              //       color: Color.fromRGBO(124, 0, 0, 1),
              //     ))
            ],
          )),
    );
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;
  final url;
  View({this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF View"),
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}
