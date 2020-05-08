import 'package:flutter/material.dart';

class DbdetailPerPage extends StatefulWidget {
  DbdetailPerPage({Key key}) : super(key: key);

  DbdetailPerPageState createState() => DbdetailPerPageState();
}

class DbdetailPerPageState extends State<DbdetailPerPage> {
  String title;
  DbdetailPerPageState({this.title = "演员表"});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
        actions: [
          new FlatButton(
              onPressed: () {},
              child: new Text('SAVE',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(color: Colors.white))),
        ],
      ),
    );
  }
}
