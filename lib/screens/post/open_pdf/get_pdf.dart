import 'package:flutter/material.dart';
import 'package:untitled/screens/post/open_pdf/view_open_pdf.dart';

class OnePdfLink extends StatelessWidget {
  const OnePdfLink({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PdfViewerPage(
                          pageUri: 'sample.pdf',
                        )),
              );
            },
            child: Text("Done Pfd")),
      ),
    );
  }
}
