import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:untitled/screens/post/post_model.dart';

class SomeSecond extends StatefulWidget {
  SomeSecond({Key? key}) : super(key: key);

  @override
  _SomeSecondState createState() => _SomeSecondState();
}

class _SomeSecondState extends State<SomeSecond> {
  late Future<PostBodyResponse> _futureResponse;

  void function() {
    var postBody12 = PostBody(name: "Anand", job: "Flutter");
    _futureResponse = postDATA(postBody12);
  }

  @override
  void initState() {
    super.initState();
    // var postBody12 = PostBody(name: "Anand", job: "Flutter");
    // _futureResponse = postDATA(postBody12);
  }

  @override
  Widget build(BuildContext context) {
    log("v");
    function();
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Data Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            //
            FutureBuilder<PostBodyResponse>(
              future: _futureResponse,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.id.toString()),
                      Text(snapshot.data!.job.toString()),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
