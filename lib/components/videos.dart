import 'package:flutter/material.dart';
import 'package:movie/net/service.dart';
import 'package:movie/model/domain.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPage createState() => _VideosPage();
}

class _VideosPage extends State<VideosPage> {

  Map<String, List<Movie>> index = {};
  List<String> categorys = [];

  @override
  initState() {
    super.initState();

    getIndex();
  }

  getIndex() async {
    index = {};
    categorys = [];

    (await Service.index()).forEach((String key,dynamic value){
      List<Movie> _list = [];
      List<Map<String,dynamic>>.from(value).forEach((_map){
        _list.add(Movie.fromJson(_map));
      });
      index[key] = _list;
    });

    index.forEach((String category,b){
      categorys.add(category);
    });

    setState(() {
      index = index;
      categorys = categorys;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: categorys.length,itemBuilder: (BuildContext context,int i) {
        String category = categorys[i];
        List<Movie> movies = index[category];

        return VideoItem(category,movies);
    });
  }
}

class VideoItem extends StatelessWidget {

  final String category;
  final List<Movie> movies;
  VideoItem(this.category,this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(child: Text(category),),
      Wrap(),
    ]));
  }
}
