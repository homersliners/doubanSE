import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flag/api/shareApi.dart';
// import 'package:spon_rating_bar/spon_rating_bar.dart';
// import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flag/assembly/starGrade.dart';

class DbTdetailPage extends StatefulWidget {
  DbTdetailPage({Key key}) : super(key: key);

  DbTdetailPageState createState() => DbTdetailPageState();
}

double contexts;

class DbTdetailPageState extends State<DbTdetailPage> {
  // 豆瓣 "top250"
  int start = 0;
  int count = 10;
  //页面显示top的数字
  int pagestart = 1;
  List listOne = [];
  bool unloing = false;
  var apiurl;
  //API
  //停止请求
  _ungetTop() async {
    CancelToken token = new CancelToken();
    Dio().get(apiurl, cancelToken: token);
// cancel the requests with "cancelled" message.
    token.cancel("cancelled");
  }

  _getTop(int a, int b) async {
    try {
      apiurl = "https://douban.uieee.com/v2/movie/top250?" +
          "start=$a" +
          "&count=10";
      var response = await Dio().get(apiurl);
      Map data = jsonDecode(response.toString());
      // list 存放top250内容
      if (data != null) {
        setState(() {
          // listOne = data["subjects"];
          List box = data["subjects"];
          box.forEach((ele) => {listOne.add(ele)});
        });
      }
    } on DioError catch (e) {
      setState(() {
        unloing = true;
      });
      if (e.response != null) {
        // print(e.response.data);
        // print(e.response.headers);
        // print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        // print(e.message);
      }
    }
  }

  @override
  void dispose() {
    listOne = [];
    super.dispose();
  }

  void initState() {
    super.initState();
    this._getTop(start, count);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // this._bottomuodate();
      }
    });
  }

  //缓刷新
  // _bottomuodate() {
  //   print("bottom");
  //   setState(() {
  //     start = start + 10;
  //     count = count + 10;
  //     this._getTop(11, 20);
  //   });
  // }
//下拉列表
  _appbarchoose() {
    List<DropdownMenuItem<dynamic>> appbarchooses = [];
    for (var i = 0; i < 25; i++) {
      int count = (i + 1) * 10;
      int sta = count - 9;
      appbarchooses.add(
        DropdownMenuItem(
          child: Text('第$sta-第$count'),
          value: i,
        ),
      );
    }
    return appbarchooses;
  }

  String title;
  DbTdetailPageState({this.title = "豆瓣Top250"});
  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    contexts = MediaQuery.of(context).size.width - 120;
    return WillPopScope(
      child: Scaffold(
          appBar: AppBar(
            title: Text(this.title),
            actions: <Widget>[
              DropdownButton(
                  hint: Text(
                    "选择排行榜",
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  items: this._appbarchoose(),
                  onChanged: (value) {
                    //禁止重复点击和加载中切换
                    if (value * 10 != pagestart - 1 && listOne.length != 0) {
                      setState(() {
                        listOne = [];
                        this._getTop(value * 10, 10);
                        pagestart = value * 10 + 1;
                      });
                    } else {}
                  })
            ],
          ),
          body: unloing == false
              ? listOne.length > 0
                  ? showTop250(listOne, _scrollController, pagestart)
                  : ingclass(true)
              : ingclass(false)),
      onWillPop: () async {
        if (listOne.length == 0) {
          await this._ungetTop();
          return true;
        }
        return true;
      },
    );
  }
}

//加载进度条
ingclass(bool type) {
  if (type == true) {
    return Center(
      child: Container(
        width: 30.0,
        height: 30.0,
        child: CircularProgressIndicator(
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
      ),
    );
  } else {
    return Center(
      child: Container(
        width: 30.0,
        height: 30.0,
        child: Text("加载失败error"),
      ),
    );
  }
}

//正常显示组件
showTop250(List listOne, ScrollController _scrollController, int pagestart) {
  return ListView.builder(
      controller: _scrollController,
      itemCount: listOne.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              addInt(
                  keys: "detailMovie", values: int.parse(listOne[index]["id"]));

              Navigator.pushNamed(context, '/dtmovie');
            },
            child: Row(
              children: <Widget>[
                //图片
                Container(
                  child: Card(
                      elevation: 8,
                      child: Image.network(
                        listOne[index]["images"]["small"],
                        fit: BoxFit.cover,
                      )),
                  margin: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  width: 100,
                  height: 150,
                ),
                //内容
                Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    width: contexts,
                    height: 150,
                    // color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListTile(
                          trailing:
                              Text("Top " + (index + pagestart).toString()),
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            listOne[index]["title"],
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            listOne[index]["original_title"] +
                                "(" +
                                listOne[index]["year"] +
                                ")",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            starGrade(
                                int.parse(listOne[index]["rating"]["stars"]),
                                0),
                            Text("  " +
                                listOne[index]["rating"]["average"].toString()),
                          ],
                        ),
                        Text(
                          unlongText(index, listOne) +
                              unlongTexts(index, listOne),
                          //     json.encode(listOne[index]["durations"]).toString(),
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ))
              ],
            ));
      });
}

unlongText(int idx, List listOne) {
  String type = "";
  for (var i = 0; i < listOne[idx]["genres"].length; i++) {
    type = type + listOne[idx]["genres"][i].toString() + " ";
  }
  return type;
}

unlongTexts(int idx, List listOne) {
  String type = "";
  for (var i = 0; i < listOne[idx]["durations"].length; i++) {
    type = type + "/" + listOne[idx]["durations"][i].toString();
  }
  return type;
}
