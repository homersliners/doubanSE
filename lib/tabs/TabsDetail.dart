import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// 侧边栏详细内容
class TabDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var drawers = Drawer(
        child: Column(children: <Widget>[
      // 列表内容
      // 头部
      Row(children: <Widget>[
        Expanded(
          child: UserAccountsDrawerHeader(
            accountName: Text(
              "user",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            accountEmail: Text("www.baidu.com"),
          ),
        ),
      ]),
// 列表
      ListTile(
        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        onTap: () {
          Navigator.pushNamed(context, '/setting');
        },
        leading: Icon(
          Icons.settings,
          // size: 28,
        ),
        title: Text(
          "设置",
          style: TextStyle(
              // fontSize: 18,
              ),
        ),
      ),
      // ListTile(
      //   contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      //   onTap: () {
      //     // Navigator.pushNamed(context, '/user');
      //     // Fluttertoast.showToast(
      //     //     msg: "未开发", backgroundColor: Theme.of(context).primaryColor);
      //   },
      //   leading: Icon(
      //     Icons.person,
      //     // size: 28,
      //   ),
      //   title: Text(
      //     "账号",
      //     style: TextStyle(
      //         // fontSize: 18,
      //         ),
      //   ),
      // ),
      ListTile(
        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        onTap: () {
          Navigator.pushNamed(context, '/about');
        },
        leading: Icon(
          Icons.info,
          // size: 28,
        ),
        title: Text(
          "关于",
          style: TextStyle(
              // fontSize: 18,
              ),
        ),
      ),
    ]));

    return drawers;
  }
}
