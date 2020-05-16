import 'package:flutter/material.dart';
import 'package:flag/api/shareApi.dart';

class DoubanTopPage extends StatefulWidget {
  DoubanTopPage({Key key}) : super(key: key);

  DoubanTopPageState createState() => DoubanTopPageState();
}

class DoubanTopPageState extends State<DoubanTopPage> {
  void initState() {
    super.initState();
  }

  List dbtop = [
    {
      "title": "豆瓣Top250",
      "router": "/edtdetail",
      "subtitle": "",
      "api": "",
    },
    {
      "title": "豆瓣电影口碑榜",
      "router": "/otherToplist",
      "subtitle": "一周口碑榜",
      "api": "weekly",
    },
    {
      "title": "豆瓣北美票房榜",
      "router": "/otherToplist",
      "subtitle": "北美票房榜",
      "api": "us_box",
    },
    {
      "title": "豆瓣电影新片榜",
      "router": "/newMovList",
      "subtitle": "电影新片榜",
      "api": "new_movies",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("豆瓣榜单集")),
      body: ListView.builder(
        itemCount: dbtop.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            // elevation: 4,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: ListTile(
              onTap: () {
                addString(
                    keys: "TopListType", values: dbtop[index]["subtitle"]);
                addString(keys: "TopListTypeApi", values: dbtop[index]["api"]);
                Navigator.pushNamed(context, dbtop[index]["router"]);
              },
              contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              title: Text(dbtop[index]["title"]),
              // trailing: Icon(Icons.keyboard_arrow_right)
            ),
          );
        },
      ),
    );
  }
}
