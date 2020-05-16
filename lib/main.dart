import 'package:flutter/material.dart';
import 'package:flag/routers/route.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flag/Theme/theme.dart';
// import 'package:flag/DrawList/Style.dart';
// import 'package:scoped_model/scoped_model.dart';
import 'package:flag/api/shareApi.dart';

void main() async {
  int themecolor = await getInt("themecolor");
  bool dark = await getBool("dark");
  bool folsys = await getBool("followSystem");
  int themecolornum;
  int darknum;
  int followof;
  //夜间模式下
  if (dark == true) {
    darknum = 1;
    themecolornum = 9;
    //存在变更themecolor
  } else if (dark != true && themecolor != null) {
    darknum = 0;
    themecolornum = themecolor;
  } else if (dark == null && themecolor == null) {
    darknum = 0;
    themecolornum = 0;
  } else {
    darknum = 0;
    themecolornum = 0;
  }
  folsys == true ? followof = 1 : followof = 0;

  runApp(ChangeNotifierProvider<Counter>.value(
      notifier: Counter(darknum, themecolornum, followof), child: MyApp()));
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 初始化路由
      initialRoute: '/',
      // 定义路由
      onGenerateRoute: onGenerateRoute,
      // 测试书签
      debugShowCheckedModeBanner: false,
      // 网格
      debugShowMaterialGrid: false,
      // 主题色
      theme: themedata(context),
      darkTheme: themedataDark(context),
    );
  }
}
