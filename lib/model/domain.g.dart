// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    img: json['img'] as String,
    quality: json['quality'] as int,
    category: (json['category'] as List)?.map((e) => e as String)?.toList(),
  )..videoUrl = json['videoUrl'] as String;
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'img': instance.img,
      'videoUrl': instance.videoUrl,
      'quality': instance.quality,
      'category': instance.category,
    };
