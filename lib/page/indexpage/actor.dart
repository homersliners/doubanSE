import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flag/api/shareApi.dart';
import 'package:flag/assembly/starGrade.dart';
import 'package:flag/assembly/loadProcess.dart';

class ActorPage extends StatefulWidget {
  ActorPage({Key key}) : super(key: key);

  ActorPageState createState() => ActorPageState();
  //  Moviemore createState() => Moviemore();
}

class ActorPageState extends State<ActorPage> {
  String title;
  String apiurl;
  String ids;
  List box = [];
  bool unloing = false;
  ActorPageState({this.title = "人物"});
  //简介
  bool showLong = false;
  //停止请求
  _ungetTop() async {
    CancelToken token = new CancelToken();
    Dio().get(apiurl, cancelToken: token);
// cancel the requests with "cancelled" message.
    token.cancel("cancelled");
  }

  _getApi() async {
    await getid();
    try {
      apiurl = "https://douban.uieee.com/v2/movie/celebrity/" + "$ids";
      var response = await Dio().get(apiurl);
      Map data = jsonDecode(response.toString());
      // list 存放top250内容
      if (data != null) {
        setState(() {
          box.add(data);
        });
      }
    } on DioError catch (e) {
      setState(() {
        unloing = true;
      });
      if (e.response != null) {
      } else {}
    }
  }

  //获取电影id
  getid() async {
    int a = await getInt("actorDetail");
    setState(() {
      ids = a.toString();
    });
  }

  void initState() {
    super.initState();
    this.getid();
    this._getApi();
  }

  @override
  Widget build(BuildContext context) {
    double wdis = MediaQuery.of(context).size.width - 180;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            // elevation: 0,
            // backgroundColor: Theme.of(context).backgroundColor,
            title: Text(this.title),
          ),
          body: unloing == false
              ? box.length == 0 ? loading() : bodys(box, context, wdis)
              : error(),
        ),
        onWillPop: () async {
          if (box.length == 0) {
            await this._ungetTop();
            return true;
          }
          return true;
        });
  }
}

bodys(List box, BuildContext context, double width) {
  return ListView(
    children: <Widget>[
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: 180,
        color: Theme.of(context).backgroundColor,
        child: Row(children: <Widget>[
          //封面
          Card(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              // width: 110,
              height: 140,
              child: Image.network(
                box[0]["avatars"]["small"] != null
                    ? box[0]["avatars"]["small"]
                    : "",
                fit: BoxFit.cover,
              ),
            ),
            // elevation: 8,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(30, 30, 10, 0),
            width: width,
            height: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      box[0]["name"],
                      style: TextStyle(fontSize: 17),
                    ),
                    subtitle: Text(
                      box[0]["name_en"],
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  box[0]["birthday"] == null
                      ? Text(
                          "无生日信息",
                          style: TextStyle(fontSize: 13),
                        )
                      : Text(
                          box[0]["birthday"],
                          style: TextStyle(fontSize: 13),
                        ),
                  box[0]["born_place"] == null
                      ? Text(
                          "无国籍信息",
                          style: TextStyle(fontSize: 13),
                        )
                      : Text(
                          box[0]["born_place"],
                          style: TextStyle(fontSize: 10),
                        )
                ]),
          ),
        ]),
      ),
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.fromLTRB(15, 8, 15, 20),
      ),
      Container(
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.fromLTRB(15, 8, 15, 20),
      )
    ],
  );
}
