import 'package:flutter/material.dart';
// import 'dart:ui';
import 'package:flag/Theme/theme.dart';
import 'package:provider/provider.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:flag/api/shareApi.dart';

class StylePage extends StatefulWidget {
  StylePage({Key key}) : super(key: key);

  StylePageState createState() => StylePageState();
}

class StylePageState extends State<StylePage> {
  bool darkof;
  bool followSystem;
  _darkchange() async {
    bool a = await getBool("followSystem");
    bool b = await getBool("dark");
    setState(() {
      b == true ? darkof = true : darkof = false;
      a == true ? followSystem = true : followSystem = false;
    });
  }

  void initState() {
    super.initState();
    this._darkchange();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("夜间模式"),
        ),
        body: ListView(children: <Widget>[
          Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
          ListTile(
            trailing: Container(
              width: 20,
              height: 20,
              child: darkof == true ? Icon(Icons.check) : Center(),
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 0, 20, 0),
            title: Text("开启"),
            onTap: () {
              //开启夜间模式
              Provider.of<Counter>(context).add();
              //顶栏设为暗夜栏色
              Provider.of<Counter>(context).countColors(9);
              addBool(keys: "dark", values: true);
              darkof = true;
            },
          ),
          Divider(),
          ListTile(
            trailing: Container(
              width: 20,
              height: 20,
              child: darkof == false ? Icon(Icons.check) : Center(),
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 0, 20, 0),
            title: Text("关闭"),
            onTap: () async {
              //关闭夜间模式
              Provider.of<Counter>(context).unadd();
              //存储本地
              addBool(keys: "dark", values: false);
              int ids = await getInt("themecolor");
              ids == null
                  ? Provider.of<Counter>(context).countColors(0)
                  : Provider.of<Counter>(context).countColors(ids);
              darkof = false;
            },
          ),
          Divider(),
          ListTile(
            trailing: Container(
              width: 20,
              height: 20,
              child: followSystem == true ? Icon(Icons.check) : Center(),
            ),
            contentPadding: EdgeInsets.fromLTRB(30, 0, 20, 0),
            title: Text("跟随系统"),
            onTap: () async {
              setState(() {
                //跟随系统
                if (followSystem == false) {
                  Provider.of<Counter>(context).followSystem();
                  followSystem = true;
                  addBool(keys: "followSystem", values: true);
                } else {
                  Provider.of<Counter>(context).unfollowSystem();
                  followSystem = false;
                  addBool(keys: "followSystem", values: false);
                }
              });
            },
          ),
          Divider()
        ]));
  }
}
