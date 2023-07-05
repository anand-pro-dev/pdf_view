// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PdfViewerPage extends StatefulWidget {
  final String pageUri;
  const PdfViewerPage({
    Key? key,
    required this.pageUri,
  }) : super(key: key);
  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  String filename = '';
  late File Pfile;
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  bool isLoading = false;
  Future<void> loadNetwork() async {
    setState(() {
      isLoading = true;
    });
    // var url = "https://class-app-server.onrender.com/${widget.pageUri}";
    // var url = "https://class-app-server.onrender.com/${widget.pageUri}";
    var url = "https://www.africau.edu/images/default/${widget.pageUri}";
    // var url = "https://www.africau.edu/images/default/sample.pdf";
    // var url = "https://www.africau.edu/images/default/sample.pdf";
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    var file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    setState(() {
      Pfile = file;
    });

    print(Pfile);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    loadNetwork();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Text(filename.toString()),
            Text("  ${currentPage! + 1}"),
            Text(" No of ${pages!}"),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {
                  Fluttertoast.showToast(
                    msg: "This will to gallery",
                    toastLength: Toast.LENGTH_SHORT,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: Center(
                child: PDFView(
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage!,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation: false,
                  filePath: Pfile.path,
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages;
                      isReady = true;
                    });
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onLinkHandler: (String? uri) {
                    print('goto uri: $uri');
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                    setState(() {
                      currentPage = page;
                    });
                  },
                ),
              ),
            ),
      // floatingActionButton: FutureBuilder<PDFViewController>(
      //   future: _controller.future,
      //   builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
      //     if (snapshot.hasData) {
      //       return FloatingActionButton.extended(
      //         label: Row(
      //           children: [
      //             Text("  ${currentPage! + 1}"),
      //             Text(" No of ${pages!}"),
      //           ],
      //         ),
      //         onPressed: () async {
      //           await snapshot.data!.setPage(pages!);
      //         },
      //       );
      //     }

      //     return Container();
      //   },
      // ),
    );
  }
}
