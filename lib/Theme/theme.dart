import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count;
  int _countColor;
  // int _backgroundcolor;
  int _countColorDark;
  Counter(this._count, this._countColor, this._countColorDark);

//修改主题色
  void countColors(int index) {
    _countColor = index;
    // _backgroundcolor =index;
    notifyListeners();
  }

//开始夜间模式
  void add() {
    _count = 1;
    notifyListeners();
  }

  //白天模式
  void unadd() {
    _count = 0;
    notifyListeners();
  }

//夜间模式跟随系统
  void followSystem() {
    _countColorDark = 1;
    notifyListeners();
  }

//夜间模式不跟随系统
  void unfollowSystem() {
    _countColorDark = 0;
    notifyListeners();
  }

  get countColorDark => _countColorDark;
  get countColor => _countColor;
  // get backgroundcolor => _backgroundcolor;
  get count => _count;
}

int nums;
int darkof;
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
List<Color> colorsFllow = [
  Colors.blue[300],
  Colors.lightBlue[300],
  Colors.teal[300],
  Colors.pink[300],
  Colors.yellow[300],
  Colors.orange[300],
  Colors.red[300],
  Colors.green[300],
  Colors.cyan[300],
  Colors.grey[700],
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

themedata(BuildContext context) {
  nums = Provider.of<Counter>(context).countColor;
  darkof = Provider.of<Counter>(context).count;
  return ThemeData(
      primaryColor: colorsList[Provider.of<Counter>(context).countColor],
      brightness: nightList[Provider.of<Counter>(context).count],
      backgroundColor: colorsFllow[Provider.of<Counter>(context).countColor]);
}

themedataDark(BuildContext context) {
  return ThemeData(
      backgroundColor: Provider.of<Counter>(context).countColorDark == 1
          ? Colors.grey[700]
          : colorsFllow[Provider.of<Counter>(context).countColor],
      primaryColor: Provider.of<Counter>(context).countColorDark == 1
          ? colorsList[9]
          : colorsList[Provider.of<Counter>(context).countColor],
      brightness: Provider.of<Counter>(context).countColorDark == 1
          ? Brightness.dark
          : nightList[Provider.of<Counter>(context).count]);
}

assemblyColor() {
  return Colors.green[600];
}

loadingColor() {
  if (darkof == 0) {
    return colorsList[nums];
  } else {
    return Colors.tealAccent;
  }
}
