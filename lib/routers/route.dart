import 'package:flutter/material.dart';
import 'package:flag/page/indexpage/dbTopList/doubanTop.dart';
import 'package:flag/tabs/Tabs.dart';
import "package:flag/DrawList/About.dart";
import 'package:flag/DrawList/Setting.dart';
import 'package:flag/DrawList/Style.dart';
import 'package:flag/DrawList/User.dart';
import 'package:flag/page/indexpage/detailmovie.dart';
import 'package:flag/DrawList/stylecolor.dart';
import 'package:flag/page/indexpage/dbTopList/dbTopKP/movieKP.dart';
import 'package:flag/page/indexpage/dbTdetailper.dart';
import 'package:flag/page/indexpage/dbTopList/dbTopnew/movieNew.dart';
import 'package:flag/page/indexpage/dbTopList/dbTopList250/dbTdetail.dart';

final routes = {
  '/dbtop': (context) => DoubanTopPage(),
  '/about': (context) => AboutPage(),
  '/': (context) => Tabs(),
  '/setting': (context) => SettingPage(),
  '/style': (context) => StylePage(),
  '/user': (context) => UserPage(),
  '/dtmovie': (context) => DetailmoviePage(),
  '/stylecolor': (context) => StyleColorPage(),
  '/edtdetail': (context) => DbTdetailPage(),
  '/dtmPer': (context) => DbdetailPerPage(),
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
