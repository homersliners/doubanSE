// import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

// 豆瓣 "最近热映"
getHotMove() async {
  var apiurl = "https://douban.uieee.com/v2/movie/in_theaters?start=0&count=10";
  var response = await Dio().get(apiurl);
  Map data = jsonDecode(response.toString());

  return data;
}

// 豆瓣 "即将上映"
getGomove() async {
  var apiurl = "https://douban.uieee.com/v2/movie/coming_soon";
  var response = await Dio().get(apiurl);
  Map data = jsonDecode(response.toString());
  return data;
}
