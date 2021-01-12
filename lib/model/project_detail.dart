part of domain;

/*
    Id          int      `json:"id"`
    Name        string   `json:"name"`
    Description string   `json:"description"`
    Img         string   `json:"img"`
    OriUrl      string   // 源站网址
    VideoUrl    string   `json:"videoUrl"` // 播放地址
    Category    []string `json:"category"` // 分类
    Quality     int      `json:"quality"`
    Online      bool
*/

@JsonSerializable()
class Movie {
  String name;
  String description;
  String img;
  String videoUrl;
  int quality;
  List<String> category;

  Movie({
    this.name,
    this.description,
    this.img,
    this.quality,
    this.category,
  });

  factory Movie.fromJson(Map<String,dynamic> json) => _$MovieFromJson(json);
    
  @override
  String toString(){
    return json.encode(this);
  }
}
