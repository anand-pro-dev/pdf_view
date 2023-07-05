import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:untitled/screens/post/open_pdf/get_pdf.dart';
import 'package:untitled/screens/post/post_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Post Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyHomePage(),
      home: OnePdfLink(),
      // home: SomeSecond(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  String _response = '';

  Future<void> _submitData() async {
    String name = _nameController.text.trim();
    String job = _jobController.text.trim();

    if (name.isNotEmpty && job.isNotEmpty) {
      try {
        var postBody = PostBody(name: name, job: job);
        var response = await postDATA(postBody);
        if (response == null) {
          log("11");
          log(response.name.toString());
        } else {
          log(response.name.toString());
          log("Success");
        }
        ;

        setState(() {
          _response =
              'Response:\nName: ${response.name}\nJob: ${response.job}\nID: ${response.id}\nCreated At: ${response.createdAt}';
        });
      } catch (e) {
        setState(() {
          _response = 'Error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Data Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(labelText: 'Job'),
            ),
            ElevatedButton(
              onPressed: _submitData,
              child: Text('Submit'),
            ),
            SizedBox(height: 16.0),
            Text(_response),
          ],
        ),
      ),
    );
  }
}
