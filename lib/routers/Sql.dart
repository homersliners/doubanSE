// import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Mysql {
  static const _VERSION = 1;
  static const _NAME = "note.db";
  static Database _database;
  static const _TABLENAME = "historyindex";
//sql 路径
  static thepath() async {
    var datadb = await getDatabasesPath();
    String path = join(datadb, _NAME);
    return path;
  }

  //初始化数据库
  static init() async {
    String a = await thepath();
    _database = await openDatabase(a, version: _VERSION,
        //table 创建初始化
        onCreate: (Database db, int version) async {
      //新建table
      /*
          ID
          nums
          title
          subtitle
          startday
           */
      await db.execute(
          'CREATE TABLE historyindex(id INTEGER PRIMARY KEY,nums INTEGER,title TEXT,subtitle TEXT,startday TEXT)');
      print("createTable is success!");
    });
  }

  //关闭数据库
  static close() {
    _database?.close();
    _database = null;
  }

  //删除sql
  static deletesql() async {
    String a = await thepath();
    await deleteDatabase(a);
  }

//-------------------------------增删查改
//插入
  Future<int> saveItem(Row row) async {
    await init();
    var dbc = _database;
    int res = await dbc.insert(_TABLENAME, row.toMap());
    return res;
  }

  //清空数据
  Future<int> clear() async {
    await init();
    var dbc = _database;
    return await dbc.delete(_TABLENAME);
  }

  //根据id删除
  Future<int> deleteItem(int id) async {
    await init();
    var dbc = _database;
    return await dbc.delete(_TABLENAME, where: "id = ?", whereArgs: [id]);
  }

//查询所有数据
  Future<List> getItem() async {
    await init();
    var dbc = _database;
    var res = await dbc.rawQuery("SELECT * FROM $_TABLENAME");
    return res;
  }

//按照id查询
  Future<Row> getItemId(int id) async {
    await init();
    var dbc = _database;
    var result = await dbc.rawQuery("SELECT * FROM $_TABLENAME WHERE id = $id");
    if (result.length == 0) return null;
    return Row.fromMap(result.first);
  }

  //修改
  Future<int> updateItem(Row row) async {
    await init();
    var dbc = _database;
    return await dbc.update("$_TABLENAME", row.toMap(),
        where: "id = ?", whereArgs: [row.id]);
  }
}

//创建row字段map
class Row {
  int id;
  int nums;
  String title;
  String subtitle;
  String startday;
//创建map方法保存字段
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['nums'] = nums;
    map['title'] = title;
    map['subtitle'] = subtitle;
    map['startday'] = startday;
    return map;
  }

//调用map方法数据
  static Row fromMap(Map<String, dynamic> map) {
    Row user = new Row();
    user.id = map['id'];
    user.nums = map['nums'];
    user.title = map['title'];
    user.subtitle = map['subtitle'];
    user.startday = map['startday'];
    return user;
  }

  static List<Row> fromMapList(dynamic mapList) {
    List<Row> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
