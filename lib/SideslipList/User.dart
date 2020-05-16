import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  UserPageState createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  String title;
  UserPageState({this.title = "账号"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
    );
  }
}
