// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson17_practice/models/comment_model.dart';

class CommentByIdScreen extends StatefulWidget {
  final int id;
  const CommentByIdScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<CommentByIdScreen> createState() => _CommentByIdScreenState();
}

class _CommentByIdScreenState extends State<CommentByIdScreen> {
  CommentModel commentModel = CommentModel();

  getCommentById() async {
    try {
      var url =
          Uri.https('jsonplaceholder.typicode.com', '/comments/${widget.id}');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      commentModel = CommentModel.fromJson(json.decode(response.body));

      setState(() {});

      return commentModel;
    } catch (e) {
      print('error = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Comment by ID screen'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(commentModel.id.toString()),
          Text(commentModel.postId.toString()),
          Text(commentModel.name ?? '-'),
          Text(commentModel.email ?? '-'),
          Text(commentModel.body ?? '-'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getCommentById();
        },
        backgroundColor: Colors.blue,
      ),
    );
  }
}
