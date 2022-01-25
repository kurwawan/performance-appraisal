import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class PostModel {
  final int id;
  final int userId;
  final String title;
  final String body;

  PostModel({this.id, this.userId, this.title, this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'] ?? "",
      body: json['body'] ?? "",
    );
  }
}

Future<PostModel> getSinglePostData(context) async {
  PostModel result;
  try {
    final response = await http.get(
      "https://jsonplaceholder.typicode.com/posts/1",
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      final item = jsonDecode(response.body);
      result = PostModel.fromJson(item);
    } else {
      print('data not found');
    }
  } catch (e) {
    log(e);
  }
  return result;
}
