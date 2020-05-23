import 'package:flutter/material.dart';
import 'package:flag/Theme/theme.dart';

//接口失败
error() {
  print("加载失败!");
  return Center(
    child: Container(
      width: 30.0,
      height: 30.0,
      child: Text("加载失败error"),
    ),
  );
}

//加载中
loading() {
  print("加载中");
  return Center(
    child: Container(
      width: 30.0,
      height: 30.0,
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(loadingColor()),
      ),
    ),
  );
}
