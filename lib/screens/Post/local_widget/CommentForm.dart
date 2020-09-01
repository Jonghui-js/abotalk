import 'package:abotalk/services/network_handler.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';

class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _globalKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController _commentController = new TextEditingController();
  bool editing = false;
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      child: Row(
        children: [
          Expanded(
            child: Container(
              constraints: BoxConstraints(maxHeight: 50, minHeight: 50),
              child: SingleChildScrollView(
                child: TextFormField(
                  // enabled: editing,
                  validator: (value) {
                    if (value.isEmpty) return '내용을 입력해주세요';
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: '내용을 입력하세요',
                    hintStyle: TextStyle(letterSpacing: 2),
                    contentPadding: EdgeInsets.all(20),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange, width: 3)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  maxLines: 10,
                  maxLength: null,
                  controller: _commentController,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          IconButton(icon: Icon(LineAwesomeIcons.comment), onPressed: () {})
        ],
      ),
    );
  }
}
