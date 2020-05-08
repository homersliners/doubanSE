import 'package:flutter/material.dart';
// import 'package:flag/routers/shareApi.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // double contexts;

  List indexpage = [
    {
      "router": "/dbtop",
      "title": "豆瓣榜单",
    },
    {
      "router": "/otherToplist",
      "title": "即将上映",
    },
    {
      "router": "/otherToplist",
      "title": "正在热映",
    }
  ];
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // contexts = MediaQuery.of(context).size.width / 2 - 10;

    return Scaffold(
        // 浮动按键
        // floatingActionButton: FloatingActionButton(
        //     backgroundColor: Theme.of(context).primaryColor,
        //     foregroundColor: Theme.of(context).textSelectionColor,
        //     child: Icon(Icons.add),
        //     onPressed: () async {
        //       await addBool(keys: "addpage", values: true);
        //       Navigator.pushNamed(context, '/add');
        //     }),
        body: ListView.builder(
      itemCount: indexpage.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            onTap: () {
              Navigator.pushNamed(context, indexpage[index]["router"]);
            },
            title: Text(indexpage[index]["title"]),
            // subtitle: Text(""),
          ),
        );
      },
    ));
  }
}
