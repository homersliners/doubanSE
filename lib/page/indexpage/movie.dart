import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flag/api/shareApi.dart';
import 'package:flag/assembly/starGrade.dart';
import 'package:flag/assembly/loadProcess.dart';

class DetailmoviePage extends StatefulWidget {
  DetailmoviePage({Key key}) : super(key: key);

  DetailmoviePageState createState() => DetailmoviePageState();
  //  Moviemore createState() => Moviemore();
}

class DetailmoviePageState extends State<DetailmoviePage> {
  String apiurl;
  String ids = "";
  List moviebox = [];
  bool show = false;
  bool unloing = false;
  String title;
  DetailmoviePageState({this.title = "电影"});
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
      apiurl = "https://douban-api.uieee.com/v2/movie/subject/" + "$ids";

      var response = await Dio().get(apiurl);
      Map data = jsonDecode(response.toString());
      // list 存放top250内容
      if (data != null) {
        setState(() {
          moviebox.add(data);
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
    int a = await getInt("detailMovie");
    setState(() {
      ids = a.toString();
    });
  }

  void initState() {
    super.initState();
    this.getid();
    this._getApi();
  }

//简介
  Widget showmore() {
    return InkWell(
      onTap: () {
        setState(() {
          showLong = true;
        });
      },
      child: Text(
        moviebox[0]["summary"],
        maxLines: showLong == false ? 5 : null,
        overflow: showLong == false ? TextOverflow.ellipsis : TextOverflow.fade,
      ),
    );
  }

  //渲染标签
  Widget buildGrid() {
    List<Widget> tiles = [];
    Widget content;
    for (var item in moviebox[0]["tags"]) {
      tiles.add(new Container(
          margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: Chip(label: Text(item))));
    }
    content = new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: tiles));
    return content;
  }

//渲染演员
  Widget actors() {
    List<Widget> tiles = [];
    Widget content;
    for (var item in moviebox[0]["directors"]) {
      tiles.add(new InkWell(
          onTap: () {
            addInt(keys: "actorDetail", values: int.parse(item["id"]));
            Navigator.pushNamed(context, '/actor');
          },
          child: item["avatars"] != null
              ? ListTile(
                  dense: true,
                  title: Text(
                    item["name"] + "（导演）",
                  ),
                  subtitle: Text(item["name_en"]),
                  leading: CircleAvatar(
                    maxRadius: 26,
                    backgroundImage: NetworkImage(
                      item["avatars"]["small"],
                    ),
                  ),
                )
              : Container()));
    }
    for (var item in moviebox[0]["writers"]) {
      tiles.add(new InkWell(
          onTap: () {
            addInt(keys: "actorDetail", values: int.parse(item["id"]));
            Navigator.pushNamed(context, '/actor');
          },
          child: item["avatars"] != null
              ? ListTile(
                  dense: true,
                  title: Text(
                    item["name"] + "（编剧）",
                  ),
                  subtitle: Text(item["name_en"]),
                  leading: CircleAvatar(
                    maxRadius: 26,
                    backgroundImage: NetworkImage(
                      item["avatars"]["small"],
                    ),
                  ),
                )
              : Container()));
    }
    for (var item in moviebox[0]["casts"]) {
      tiles.add(new InkWell(
          onTap: () {
            addInt(keys: "actorDetail", values: int.parse(item["id"]));
            Navigator.pushNamed(context, '/actor');
          },
          child: item["avatars"] != null
              ? ListTile(
                  dense: true,
                  title: Text(
                    item["name"] + "（主演）",
                  ),
                  subtitle: Text(item["name_en"]),
                  leading: CircleAvatar(
                    maxRadius: 26,
                    backgroundImage: NetworkImage(
                      item["avatars"]["small"],
                    ),
                  ),
                )
              : Container()));
    }
    content = ListView(children: tiles);

    return content;
  }

  //渲染剧照
  Widget photo() {
    List<Widget> tiles = [];
    Widget content;
    for (var item in moviebox[0]["photos"]) {
      tiles.add(new InkWell(
        onTap: () {},
        child: Container(
            width: 250,
            height: 150,
            child: Card(
              child: item != null
                  ? Image.network(
                      item["image"],
                      fit: BoxFit.cover,
                    )
                  : Center(),
            )),
      ));
    }
    content = SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: tiles));
    return content;
  }

//渲染评论
  Widget popularComments() {
    List<Widget> tiles = [
      Padding(
        padding: EdgeInsets.fromLTRB(4, 8, 0, 20),
        child: Flex(direction: Axis.horizontal, children: <Widget>[
          Expanded(
            flex: 16,
            child: Text(
              "热评" + " " + moviebox[0]["comments_count"].toString(),
              style: TextStyle(fontSize: 14),
            ),
          ),
          Expanded(flex: 2, child: Icon(Icons.keyboard_arrow_right))
        ]),
      )
    ];
    Widget content;
    for (var item in moviebox[0]["popular_comments"]) {
      tiles.add(
        new ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              item["author"]["avatar"],
            ),
          ),
          isThreeLine: true,
          dense: true,
          // trailing: Text(data),
          title: Text(
            item["author"]["name"],
            style: TextStyle(fontSize: 13),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 4, 4, 4),
                child: Row(children: <Widget>[
                  perStar(item["rating"]["value"].toInt()),
                  // Text("   " + shoetime(item["created_at"]))
                ]),
              ),
              Text(
                item["content"],
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }
    content = new Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: tiles);
    return content;
  }

  @override
  Widget build(BuildContext context) {
    double wdis = MediaQuery.of(context).size.width;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            // elevation: 0,
            // backgroundColor: Theme.of(context).backgroundColor,
            title: Text(this.title),
          ),
          body: unloing == false
              ? moviebox.length == 0
                  ? loading()
                  : bodys(wdis, context, moviebox, buildGrid(),
                      popularComments(), actors(), showmore(), photo())
              : error(),
        ),
        onWillPop: () async {
          if (moviebox.length == 0) {
            await this._ungetTop();
            return true;
          }
          return true;
        });
  }
}

bodys(double wids, BuildContext context, List moviebox, Widget exampleWidget,
    Widget popularComments, Widget actors, Widget showmore, Widget photo) {
  return ListView(
    children: <Widget>[
      //封面+文字
      Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
        height: 200,
        color: Theme.of(context).backgroundColor,
        child: Row(children: <Widget>[
          //封面
          Card(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Container(
              width: 110,
              height: 160,
              child: Image.network(
                moviebox[0]["images"]["small"] != null
                    ? moviebox[0]["images"]["small"]
                    : "",
                fit: BoxFit.cover,
              ),
            ),
            elevation: 8,
          ),
          Container(
              // color: Colors.yellowAccent,
              width: wids - 130,
              padding: EdgeInsets.fromLTRB(20, 18, 10, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text(
                          moviebox[0]["title"],
                          style: TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(moviebox[0]["original_title"] +
                            "(" +
                            moviebox[0]["year"].toString() +
                            ")")),
                    Row(children: <Widget>[
                      starGrade(int.parse(moviebox[0]["rating"]["stars"]), 1),
                      Text(
                        "  " + moviebox[0]["rating"]["average"].toString(),
                        style: TextStyle(fontSize: 18),
                      )
                    ]),
                    Divider(),
                    Text(
                      movietype(moviebox) + othername(moviebox),
                      maxLines: 3,
                      style: TextStyle(fontSize: 10),
                    ),
                  ]))
        ]),
      ),
      //电影简介
      Container(
        // color: Colors.greenAccent,
        padding: EdgeInsets.all(14),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "简介",
                style: TextStyle(fontSize: 16),
              ),
              Divider(),
              showmore,
            ]),
      ),
      Divider(),
//演员表
      Container(
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(14, 0, 10, 0),
          trailing: Icon(Icons.keyboard_arrow_right),
          dense: true,
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 500), //动画时间为500毫秒
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return new FadeTransition(
                    //使用渐隐渐入过渡,
                    opacity: animation,
                    child: Scaffold(
                        appBar: AppBar(title: Text("演职人员")),
                        body: actors), //路由B
                  );
                },
              ),
            );
          },
          title: Text('导演/编剧/主演'),
        ),
      ),

      //剧照
      Container(
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(14, 0, 10, 0),
          trailing: Icon(Icons.keyboard_arrow_right),
          dense: true,
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 300), //动画时间为500毫秒
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  return new FadeTransition(
                    //使用渐隐渐入过渡,
                    opacity: animation,
                    child: Scaffold(
                        appBar: AppBar(title: Text("剧照")),
                        body: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, //横轴三个子widget
                                    childAspectRatio: 1.0 //宽高比为1时，子widget
                                    ),
                            itemCount: moviebox[0]["photos"].length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: Image.network(
                                  moviebox[0]["photos"][index]["image"],
                                  fit: BoxFit.cover,
                                ),
                              );
                            })), //路由B
                  );
                },
              ),
            );
          },
          title: Text('剧照'),
        ),
      ),
      // Container(
      //   decoration: BoxDecoration(
      //     // color: Theme.of(context).cardColor,
      //     borderRadius: BorderRadius.circular(14.0),
      //   ),
      //   margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      //   padding: EdgeInsets.all(0),
      //   // child: photo,
      // ),
      Divider(),
      //电影属性
      Container(
        margin: EdgeInsets.all(10),
        child: exampleWidget,
      ),
      //评论
      Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(14.0),
          ),
          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
          padding: EdgeInsets.fromLTRB(15, 8, 15, 20),
          child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/comment');
              },
              child: popularComments)),
    ],
  );
}

movietype(List box) {
  String type = "语言：";
  for (var i = 0; i < box[0]["languages"].length; i++) {
    type = type + " " + box[0]["languages"][i].toString();
  }
  type = type + "/";
  for (var i = 0; i < box[0]["genres"].length; i++) {
    type = type + " " + box[0]["genres"][i].toString();
  }
  type = type + "/" + "上映：";
  for (var i = 0; i < box[0]["pubdates"].length; i++) {
    type = type + " " + box[0]["pubdates"][i].toString();
  }
  type = type + "/" + "片长：";
  for (var i = 0; i < box[0]["durations"].length; i++) {
    type = type + " " + box[0]["durations"][i].toString();
  }
  return type;
}

othername(List box) {
  String type = "/" + "别名：";
  for (var i = 0; i < box[0]["aka"].length; i++) {
    type = type + " " + box[0]["aka"][i].toString();
  }

  return type;
}
