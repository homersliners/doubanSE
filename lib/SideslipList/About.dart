import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  String title;
  PackageInfo packageInfo;
  String name;
  String versions;
  @override
  void initState() {
    super.initState();
    this._getmyapp();
  }

  _getmyapp() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        this.packageInfo = packageInfo;
        name = packageInfo.appName;
        versions = packageInfo.version;
      });
    });
  }

  AboutPageState({this.title = "关于"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView(children: <Widget>[
        ListTile(
          title: Text("名称"),
          subtitle: name == null ? Text("") : Text(name),
          onTap: () {},
          contentPadding: EdgeInsets.fromLTRB(26, 0, 0, 0),
        ),
        ListTile(
          title: Text("版本号"),
          subtitle: versions == null ? Text("") : Text(versions),
          onTap: () {},
          contentPadding: EdgeInsets.fromLTRB(26, 0, 0, 0),
        ),
        ListTile(
          title: Text("联系开发者"),
          subtitle: Text("homer"),
          onTap: () {},
          contentPadding: EdgeInsets.fromLTRB(26, 0, 0, 0),
        ),
        ListTile(
          title: Text("分享"),
          subtitle: Text("分享此app"),
          trailing: Icon(Icons.share),
          onTap: () {},
          contentPadding: EdgeInsets.fromLTRB(26, 0, 20, 0),
        ),
        // Divider(),
      ]),
    );
  }
}
