import 'package:flutter/material.dart';
// import 'dart:math';

Widget starGrade(int aa, int type) {
  int full = (aa / 10).floor();
  int bor = (aa - (aa / 10).floor() * 10);
  List<Widget> tiles = [];
  Widget content;
  // print(full); //满星数
  // print(bor); //半星数

  for (var i = 0; i < full; i++) {
    tiles.add(star(2, type));
  }
  for (var i = 0; i < 5 - full; i++) {
    if (i == 0 && bor != 0) {
      tiles.add(star(1, type));
    } else {
      tiles.add(star(0, type));
    }
  }
  content = new Container(child: Row(children: tiles));
  return content;
}

Widget star(int del, int type) {
  if (del == 0) {
    return Icon(
      Icons.star_border,
      color: Colors.teal,
      size: type == 1 ? 20 : 14,
    );
  } else if (del == 1) {
    return Icon(
      Icons.star_half,
      color: Colors.green[600],
      size: type == 1 ? 20 : 14,
    );
  } else {
    return Icon(
      Icons.star,
      color: Colors.green[600],
      size: type == 1 ? 20 : 14,
    );
  }
}

Widget perStar(int stars) {
  List<Widget> tiles = [];
  Widget content;
  for (var i = 0; i < stars; i++) {
    tiles.add(perstarshow(1));
  }
  for (var i = 0; i < 5 - stars; i++) {
    tiles.add(perstarshow(0));
  }
  content = new Container(child: Row(children: tiles));
  return content;
}

perstarshow(int type) {
  if (type == 1) {
    return Icon(
      Icons.star,
      color: Colors.green[600],
      size: 12,
    );
  } else {
    return Icon(
      Icons.star_border,
      color: Colors.teal,
      size: 12,
    );
  }
}

error() {
  return Center(
    child: Container(
      width: 30.0,
      height: 30.0,
      child: Text("加载失败error"),
    ),
  );
}

loading() {
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
}