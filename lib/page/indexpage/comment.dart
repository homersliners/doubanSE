import 'package:flutter/material.dart';
import 'package:flag/assembly/useful.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flag/api/shareApi.dart';
import 'package:flag/assembly/starGrade.dart';
import 'package:flag/assembly/loadProcess.dart';

class CommentPage extends StatefulWidget {
  CommentPage({Key key}) : super(key: key);

  CommentPageState createState() => CommentPageState();
}

class CommentPageState extends State<CommentPage> {
  String title;
  String apiurl;
  String ids;
  List commentbox = [];
  //简介
  bool unloing = false;
  //停止请求
  _ungetTop() async {
    CancelToken token = new CancelToken();
    Dio().get(apiurl, cancelToken: token);
// cancel the requests with "cancelled" message.
    token.cancel("cancelled");
  }

  //获取电影id
  getid() async {
    int a = await getInt("detailMovie");
    setState(() {
      ids = a.toString();
    });
  }

  //API
  _getApi() async {
    await getid();
    try {
      apiurl =
          "https://douban.uieee.com/v2/movie/subject/" + "$ids" + "/comments";
      var response = await Dio().get(apiurl);
      Map data = jsonDecode(response.toString());
      if (data != null) {
        setState(() {
          commentbox.add(data);
        });
      }
    } on DioError catch (e) {
      print("error");
      setState(() {
        unloing = true;
      });
      if (e.response != null) {
      } else {}
    }
  }

  void initState() {
    super.initState();
    this.getid();
    this._getApi();
  }

  CommentPageState({this.title = "热门评论"});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(this.title),
          ),
          body: unloing == true
              ? error()
              : commentbox.length == 0 ? loading() : bodys(commentbox),
        ),
        onWillPop: () async {
          if (commentbox.length == 0) {
            await this._ungetTop();
            return true;
          }
          return true;
        });
  }
}

bodys(List box) {
  return ListView.builder(
      itemCount: box[0]["count"],
      itemBuilder: (context, index) {
        return ListTile(
            trailing: useful(box[0]["comments"][index]["useful_count"]),
            contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            dense: true,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                box[0]["comments"][index]["author"]["avatar"],
              ),
            ),
            title: Text(box[0]["comments"][index]["author"]["name"]),
            isThreeLine: true,
            subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 4, 4, 4),
                    child: Row(children: <Widget>[
                      perStar(
                          box[0]["comments"][index]["rating"]["value"].toInt()),
                    ]),
                  ),
                  Text(box[0]["comments"][index]["content"]),
                ]));
      });
}
