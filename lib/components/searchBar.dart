import 'package:flutter/material.dart';
import 'dart:ui';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          top: MediaQueryData.fromWindow(window).padding.top,
        ),
        child: Container(
          child: new Padding(
              padding: const EdgeInsets.all(6.0),
              child: new Card(
                  child: new Container(
                child: new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 5.0,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: controller,
                          decoration: new InputDecoration(
                              // contentPadding: EdgeInsets.only(top: 0.0),
                              hintText: '搜索 电影名称、演员、类型',
                              border: InputBorder.none),
                          // onChanged: onSearchTextChanged,
                        ),
                      ),
                    ),
                    new IconButton(
                      icon: new Icon(Icons.cancel),
                      color: Colors.grey,
                      iconSize: 18.0,
                      onPressed: () {
                        controller.clear();
                        // onSearchTextChanged('');
                      },
                    ),
                  ],
                ),
              ))),
        ));
  }
}
