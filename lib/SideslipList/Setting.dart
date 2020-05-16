import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key);

  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  String title;
  SettingPageState({this.title = "设置"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView(children: <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(30, 0, 20, 0),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, '/style');
          },
          title: Text(
            "夜间模式",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        Divider(),
        ListTile(
          contentPadding: EdgeInsets.fromLTRB(30, 0, 20, 0),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.pushNamed(context, '/stylecolor');
          },
          title: Text(
            "主题风格",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ]),
    );
  }
}
