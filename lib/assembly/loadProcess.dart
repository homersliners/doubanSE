import 'package:flutter/material.dart';

//接口失败
error() {
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
  return Center(
    child: Container(
      width: 30.0,
      height: 30.0,
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[200],
        valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
      ),
    ),
  );
}
