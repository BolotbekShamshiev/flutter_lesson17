import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lesson17_practice/models/comment_model.dart';
import 'package:lesson17_practice/screens/comment_by_id_screen.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  List<CommentModel> commentsList = [];

  getAllComents() async {
    try {
      var url = Uri.https('jsonplaceholder.typicode.com', '/comments');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      commentsList = json
          .decode(response.body)
          .map<CommentModel>((json) => CommentModel.fromJson(json))
          .toList();

      setState(() {});

      return commentsList;
    } catch (e) {
      print('error = $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Comments Screen'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: commentsList.length,
        itemBuilder: (contex, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (contex) => CommentByIdScreen(
                    id: commentsList[index].id ?? 0,
                  ),
                ),
              );
            },
            child: Container(
              color: Colors.green,
              child: Column(
                children: [
                  Text(commentsList[index].id.toString()),
                  Text(commentsList[index].postId.toString()),
                  Text(commentsList[index].name ?? '-'),
                  Text(commentsList[index].email ?? '-'),
                  Text(commentsList[index].body ?? '-'),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 16);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          getAllComents();
        },
      ),
    );
  }
}
