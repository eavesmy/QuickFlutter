import 'package:flutter/material.dart';
import 'package:movie/net/service.dart';
import 'package:movie/model/domain.dart';
import 'package:movie/components/searchBar.dart';
import 'package:movie/components/video.dart';

class VideosPage extends StatefulWidget {
  @override
  _VideosPage createState() => _VideosPage();
}

class _VideosPage extends State<VideosPage> with AutomaticKeepAliveClientMixin {
  Map<String, List<Movie>> index = {};
  List<String> categorys = [];

  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    super.initState();

    getIndex();
  }

  getIndex() async {
    index = {};
    categorys = [];

    (await Service.index()).forEach((String key, dynamic value) {
      List<Movie> _list = [];
      List<Map<String, dynamic>>.from(value).forEach((_map) {
        _list.add(Movie.fromJson(_map));
      });
      index[key] = _list;
    });

    index.forEach((String category, b) {
      categorys.add(category);
    });

    setState(() {
      index = index;
      categorys = categorys;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(),
        Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: categorys.length,
                itemBuilder: (BuildContext context, int i) {
                  String category = categorys[i];
                  List<Movie> movies = index[category];

                  return Category(category, movies);
                })),
      ],
    );
  }
}

class Category extends StatelessWidget {
  final String category;
  final List<Movie> movies;
  Category(this.category, this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i) =>
                  VideoItem(movies[i]),
              itemCount: movies.length),
        ));
  }
}

class VideoItem extends StatelessWidget {
  Movie movie;
  VideoItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(flex: 2, child: Image.network(movie.img)),
      Expanded(
          flex: 5,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                    title: Text(movie.name), subtitle: Text(movie.description)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton.icon(
                        onPressed: () {
                          // 跳转播放界面
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => VideoPage(movie.id)));
                        },
                        icon: Icon(Icons.play_arrow),
                        label: Text("播放"),
                        color: Colors.teal,
                        textColor: Colors.white),
                  ],
                )
              ])),
    ]));
  }
}
