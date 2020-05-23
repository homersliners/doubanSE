import 'package:flutter/material.dart';
import 'package:flag/Theme/theme.dart';

//点赞组件
useful(int ids) {
  String shownum = "";
  if (ids > 10000) {
    shownum = (ids / 10000).floor().toString() + "w+";
  } else {
    shownum = ids.toString();
  }
  return Container(
    width: 45,
    height: 20,
    // color: Colors.yellow,
    child: Row(
      children: <Widget>[
        Icon(
          Icons.thumb_up,
          size: 13,
          color: assemblyColor(),
        ),
        Text(
          "  " + shownum,
          style: TextStyle(fontSize: 11),
        )
      ],
    ),
  );
}
