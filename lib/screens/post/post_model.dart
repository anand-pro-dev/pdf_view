import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostBody {
  final String name;
  final String job;

  PostBody({required this.name, required this.job});

  factory PostBody.fromJson(Map<String, dynamic> json) {
    return PostBody(
      name: json['name'],
      job: json['job'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'job': job,
    };
  }
}

class PostBodyResponse {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  PostBodyResponse(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});

  factory PostBodyResponse.fromJson(Map<String, dynamic> json) {
    return PostBodyResponse(
      name: json['name'],
      job: json['job'],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }
}

Future<PostBodyResponse> postDATA(PostBody postBody) async {
  var baseUrl = 'https://reqres.in/api/users'; // Replace with your API endpoint
  var url = Uri.parse(baseUrl);
  var _payload = json.encode(postBody.toJson());
  var _headers = {'Content-Type': 'application/json'};

  var response = await http.post(url, body: _payload, headers: _headers);
  if (response.statusCode == 201) {
    var result = jsonDecode(response.body);
    log(response.body.toString());
    log(result.toString());
    return PostBodyResponse.fromJson(result);
  } else {
    throw Exception('Failed to post data');
  }
}
