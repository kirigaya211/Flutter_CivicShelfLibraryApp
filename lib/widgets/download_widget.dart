// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:civic_shelf_mobile_app/widgets/check_permission.dart';
import 'package:civic_shelf_mobile_app/widgets/directory_path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// Create a singleton class to manage data
class FileListData {
  static final FileListData _singleton = FileListData._internal();

  factory FileListData() {
    return _singleton;
  }

  FileListData._internal();

  List<Map<String, String>> dataList = [];
}

class FileList extends StatefulWidget {
  const FileList({Key? key});

  @override
  State<FileList> createState() => _FileListState();

  static void addNewFile(String title, String url) {
    // Access the singleton instance and update data
    FileListData().dataList.add({
      "title": title,
      "url": url,
    });
  }
}

class _FileListState extends State<FileList> {
  bool isPermission = false;
  var checkAllPermissions = CheckPermission();

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    var permission = await checkAllPermissions.isStoragePermission();
    if (permission) {
      setState(() {
        isPermission = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isPermission
          ? ListView.builder(
              itemCount: FileListData().dataList.length,
              itemBuilder: (BuildContext context, int index) {
                var data = FileListData().dataList[index];
                return TileList(
                  fileUrl: data['url']!,
                  title: data['title']!,
                );
              },
            )
          : TextButton(
              onPressed: () {
                checkPermission();
              },
              child: const Text("Permission issue"),
            ),
    );
  }
}

class TileList extends StatefulWidget {
  const TileList({Key? key, required this.fileUrl, required this.title});
  final String fileUrl;
  final String title;

  @override
  State<TileList> createState() => _TileListState();
}

class _TileListState extends State<TileList> {
  bool downloading = false;
  bool fileExists = false;
  double progress = 0;
  String fileName = "";
  late String filePath;
  late CancelToken cancelToken;
  var getPathFile = DirectoryPath();

  @override
  void initState() {
    super.initState();
    setState(() {
      fileName = Path.basename(widget.fileUrl);
    });
    cancelToken = CancelToken();
    checkFileExit();
  }

  startDownload() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    setState(() {
      downloading = true;
      progress = 0;
    });

    try {
      await Dio().download(widget.fileUrl, filePath,
          onReceiveProgress: (count, total) {
        setState(() {
          progress = count / total;
        });
      }, cancelToken: cancelToken);
      setState(() {
        downloading = false;
        fileExists = true;
      });
    } catch (e) {
      print(e);
      setState(() {
        downloading = false;
      });
    }
  }

  cancelDownload() {
    cancelToken.cancel();
    setState(() {
      downloading = false;
    });
  }

  checkFileExit() async {
    var storePath = await getPathFile.getPath();
    filePath = '$storePath/$fileName';
    bool fileExistCheck = await File(filePath).exists();
    setState(() {
      fileExists = fileExistCheck;
    });
  }

  openFile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => View(
          url: filePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.shade100,
      child: ListTile(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () {
            fileExists && !downloading ? openFile() : cancelDownload();
          },
          icon: fileExists && !downloading
              ? const Icon(
                  Icons.window,
                  color: Colors.green,
                )
              : const Icon(Icons.close),
        ),
        trailing: IconButton(
          onPressed: () {
            fileExists && !downloading ? openFile() : startDownload();
          },
          icon: fileExists
              ? const Icon(
                  Icons.save,
                  color: Colors.green,
                )
              : downloading
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 3,
                          backgroundColor: Colors.grey,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                        Text(
                          "${(progress * 100).toStringAsFixed(2)}",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  : const Icon(Icons.download),
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
      height: 800.0,
      child: SfPdfViewer.file(
        File(url),
        controller: _pdfViewerController,
      ),
    );
  }
}
