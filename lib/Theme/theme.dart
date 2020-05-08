import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
// import 'package:scoped_model/scoped_model.dart';
// import 'package:flag/routers/shareApi.dart';

class Counter with ChangeNotifier {
  int _count;
  int _countColor;
  int _countColorDark;
  Counter(this._count, this._countColor, this._countColorDark);
  //change themecolor
  void countColors(int index) {
    _countColor = index;
    notifyListeners();
  }

//dark
  void add() {
    _count = 1;
    notifyListeners();
  }

  void followSystem() {
    _countColorDark = 1;
    notifyListeners();
  }

  void unfollowSystem() {
    _countColorDark = 0;
    notifyListeners();
  }

//light
  void unadd() {
    _count = 0;
    notifyListeners();
  }

  get countColorDark => _countColorDark;
  get countColor => _countColor;
  get count => _count;
}

List<Brightness> nightList = [Brightness.light, Brightness.dark];
List<Color> colorsList = [
  Colors.blue,
  Colors.lightBlue,
  Colors.teal,
  Colors.pink,
  Colors.yellow,
  Colors.orange,
  Colors.red,
  Colors.green,
  Colors.cyan,
  Colors.grey[900],
  Colors.black,
];
List<Text> colorsListText = [
  Text("基础蓝"),
  Text("天空蓝"),
  Text("茶色"),
  Text("骚粉"),
  Text("基础黄"),
  Text("基础橙"),
  Text("彤彤红"),
  Text("小草绿"),
  Text("淡灰色"),
  Text("棕色"),
  Text("暗夜黑"),
];
