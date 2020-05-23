import 'package:flutter/material.dart';
import 'package:flag/page/indexpage/doubanList/doubanTop.dart';
import 'package:flag/tabs/Tabs.dart';
import "package:flag/SideslipList/About.dart";
import 'package:flag/SideslipList/Setting.dart';
import 'package:flag/SideslipList/Style.dart';
import 'package:flag/SideslipList/User.dart';
import 'package:flag/page/indexpage/movie.dart';
import 'package:flag/SideslipList/stylecolor.dart';
import 'package:flag/page/indexpage/doubanList/doubanTopList/doubanTopList.dart';
import 'package:flag/page/indexpage/comment.dart';
import 'package:flag/page/indexpage/actor.dart';
import 'package:flag/page/indexpage/doubanList/doubanNewTopList/movieNew.dart';
import 'package:flag/page/indexpage/doubanList/dbTopList250/dbTdetail.dart';

final routes = {
  '/dbtop': (context) => DoubanTopPage(),
  '/about': (context) => AboutPage(),
  '/': (context) => Tabs(),
  '/setting': (context) => SettingPage(),
  '/style': (context) => StylePage(),
  '/user': (context) => UserPage(),
  '/comment': (context) => CommentPage(),
  '/dtmovie': (context) => DetailmoviePage(),
  '/stylecolor': (context) => StyleColorPage(),
  '/edtdetail': (context) => DbTdetailPage(),
  '/actor': (context) => ActorPage(),
  '/newMovList': (context) => MovieNewListPage(),
  '/otherToplist': (context) => OtherListPage(),
};

var onGenerateRoute = (RouteSettings settings) {
  // 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
