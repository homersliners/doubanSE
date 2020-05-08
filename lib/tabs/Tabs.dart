import 'package:flag/page/Index.dart';
import 'package:flutter/material.dart';
import 'package:flag/page/Book.dart';
import 'TabsDetail.dart';

class Tabs extends StatefulWidget {
  Tabs({Key key}) : super(key: key);

  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  List _box = [IndexPage(), SettingPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 内容
      body: this._box[_currentIndex],
      // 侧边栏
      drawer: TabDetail(),
      // 顶部栏
      appBar: AppBar(
        title: Text("豆小瓣"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       showSearch(context: context, delegate: searchBarDelegate());
        //     },
        //   )
        // ],
      ),
      // 底部栏
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this._currentIndex,
        iconSize: 20.0,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text("主页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text("更多"),
          )
        ],
      ),
    );
  }
}

// class searchBarDelegate extends SearchDelegate<String> {
// //重写右侧的图标
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         //将搜索内容置为空
//         onPressed: () => query = "",
//       )
//     ];
//   }

// //重写返回图标
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: AnimatedIcon(
//             icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
//         //关闭上下文，当前页面
//         onPressed: () => close(context, null));
//   }

//   //重写搜索结果
//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       width: 100.0,
//       height: 100.0,
//       child: Card(
//         color: Colors.redAccent,
//         child: Center(
//           child: Text(query),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     return Center();
//   }

// // @override
// //   Widget buildSuggestions(BuildContext context){
// //     final suggestionList = query.isEmpty
// //         ? recentSuggest
// //         : searchList.where((input)=> input.startsWith(query)).toList();

// //     return ListView.builder(
// //       itemCount: suggestionList.length ,
// //         itemBuilder: (context,index)=>ListTile(
// //           title: RichText(text: TextSpan(text: suggestionList[index].substring(0,query.length),
// //           style:TextStyle(
// //               color: Colors.black,fontWeight: FontWeight.bold),
// //             children: [
// //               TextSpan(
// //                 text: suggestionList[index].substring(query.length),
// //                 style: TextStyle(color: Colors.grey)

// //               )
// //             ]
// //           ),
// //           ),
// //         )
// //     );
// //   }

// }
