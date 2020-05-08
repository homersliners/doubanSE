import 'package:flutter/material.dart';
import 'package:flag/assembly/starGrade.dart';
import 'package:flag/routers/shareApi.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class OtherListPage extends StatefulWidget {
  OtherListPage({Key key}) : super(key: key);

  OtherListPageState createState() => OtherListPageState();
}

class OtherListPageState extends State<OtherListPage> {
  bool unloing = false;
  var apiurl;
  String apitype = "";
  List movList = [];
  titletype() async {
    String a = await getString("TopListType");
    String apis = await getString("TopListTypeApi");
    setState(() {
      title = a;
      apitype = apis;
    });
  }

  //停止请求
  _ungetTop() async {
    CancelToken token = new CancelToken();
    Dio().get(apiurl, cancelToken: token);
// cancel the requests with "cancelled" message.
    token.cancel("cancelled");
  }

  _getApi() async {
    await titletype();
    try {
      apiurl = "https://douban.uieee.com/v2/movie/" + apitype;
      var response = await Dio().get(apiurl);
      Map data = jsonDecode(response.toString());
      if (data != null) {
        setState(() {
          List box = data["subjects"];
          box.forEach((ele) => {movList.add(ele)});
        });
      }
    } on DioError {
      setState(() {
        unloing = true;
      });
    }
  }

  void initState() {
    super.initState();
    this.titletype();
    this._getApi();
  }

  String title;
  OtherListPageState({this.title = ""});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text(this.title),
            ),
            body: unloing == true
                ? error()
                : movList.length == 0 ? loading() : bodys(movList)),
        onWillPop: () async {
          if (unloing != true && movList.length == 0) {
            this._ungetTop();
            return true;
          } else {
            return true;
          }
        });
  }
}

bodys(List movList) {
  double height = 160;
  return ListView.builder(
      itemCount: movList.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            addInt(
                keys: "detailMovie",
                values: int.parse(movList[index]["subject"]["id"]));

            Navigator.pushNamed(context, '/dtmovie');
          },
          child: Row(children: <Widget>[
            //数字
            Container(
              width: 40,
              height: height,
              // color: Colors.greenAccent,
              child: Center(
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(fontSize: 19),
                ),
              ),
            ),
            //封面
            Container(
              // color: Colors.blueAccent,
              // height: height,
              child: Card(
                  elevation: 8,
                  child: Image.network(
                    movList[index]["subject"]["images"]["small"] != null
                        ? movList[index]["subject"]["images"]["small"]
                        : "",
                    fit: BoxFit.cover,
                  )),
              // margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
              width: 90,
              height: 130,
            ),
            //内容
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              width: 250,
              height: height,
              // color: Colors.greenAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                      // onTap: () {
                      //   print(movList[index]["subject"]["rating"]["stars"]);
                      // },
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      title: Text(movList[index]["subject"]["title"]),
                      subtitle: Text(movList[index]["subject"]
                              ["original_title"] +
                          " " +
                          "(" +
                          movList[index]["subject"]["year"] +
                          ")")),
                  Row(
                    children: <Widget>[
                      starGrade(
                          int.parse(
                              movList[index]["subject"]["rating"]["stars"]),
                          0),
                      Text("  " +
                          movList[index]["subject"]["rating"]["average"]
                              .toString()),
                    ],
                  ),
                  Text(
                    unlong(index, movList),
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        );
      });
}

unlong(int idx, List box) {
  String type = "";
  for (var i = 0; i < box[idx]["subject"]["genres"].length; i++) {
    type = type + box[idx]["subject"]["genres"][i] + " ";
  }
  type = type + "/";
  for (var i = 0; i < box[idx]["subject"]["durations"].length; i++) {
    type = type + box[idx]["subject"]["durations"][i] + " ";
  }
  return type;
}
