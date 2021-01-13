import 'package:flutter/material.dart';
import 'package:movie/components/videos.dart';
import 'package:movie/components/my.dart';

class MyApp extends StatefulWidget{
    @override
    _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  int index = 0;
  List<Widget> bodyList = [VideosPage(),MyPage()];

  select(i){
    setState(() {
        index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: bodyList[index],
        bottomNavigationBar: BottomNavigationBar(
            onTap: select,
            currentIndex: index,
            items: [
                BottomNavigationBarItem(label: "片源",icon: Icon(Icons.movie)),
                BottomNavigationBarItem(label: "我的",icon: Icon(Icons.account_circle)),
            ]),
    );
  }
}
