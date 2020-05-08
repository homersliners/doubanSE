import 'package:flutter/material.dart';
import 'package:flag/Theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:flag/routers/shareApi.dart';

class StyleColorPage extends StatefulWidget {
  StyleColorPage({Key key}) : super(key: key);

  StyleColorPageState createState() => StyleColorPageState();
}

class StyleColorPageState extends State<StyleColorPage> {
  String title;
  int ids;
  _numcheck() async {
    int a = await getInt("themecolor");
    if (a == null) {
      ids = 0;
    } else {
      setState(() {
        ids = a;
      });
    }
  }

  void initState() {
    super.initState();
    this._numcheck();
  }

  StyleColorPageState({this.title = "主题风格"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        body: ListView.builder(
            itemCount: colorsList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                    color: colorsList[index],
                    width: 40,
                    height: 40,
                    child: ids == index ? Icon(Icons.check) : Center()),
                title: colorsListText[index],
                onTap: () {
                  //更换主题
                  Provider.of<Counter>(context).countColors(index);
                  //恢复白天模式
                  Provider.of<Counter>(context).unadd();
                  //存储本地
                  int cos = index;
                  addInt(keys: "themecolor", values: cos);
                  addBool(keys: "dark", values: false);
                  ids = index;
                },
              );
            }));
  }
}
