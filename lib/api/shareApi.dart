import 'package:shared_preferences/shared_preferences.dart';

// //新增Int
addInt({String keys, int values}) async {
  print(values);
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setInt(keys, values);
}

//新增String
addString({String keys, String values}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString(keys, values);
}

//新增bool
addBool({String keys, bool values}) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setBool(keys, values);
}

// //获取数据
getInt(String keys) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getInt(keys);
}

getString(String keys) async {
  SharedPreferences sp = await SharedPreferences.getInstance();
  return sp.getString(keys);
}

getBool(String keys) async {
  SharedPreferences sp = await SharedPreferences.getInstance();

  return sp.getBool(keys);
}

// //删除
// delSQL(String keys) async {
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   sp.remove(keys);
// }
