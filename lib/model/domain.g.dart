// GENERATED CODE - DO NOT MODIFY BY HAND

part of domain;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectDetail _$ProjectDetailFromJson(Map<String, dynamic> json) {
  return ProjectDetail(
    chartData: (json['chartData'] as List)
        ?.map((e) =>
            e == null ? null : ChartData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    recentBuild: (json['recentBuild'] as List)
        ?.map((e) =>
            e == null ? null : RecentBuild.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProjectDetailToJson(ProjectDetail instance) =>
    <String, dynamic>{
      'chartData': instance.chartData,
      'recentBuild': instance.recentBuild,
    };

ChartData _$ChartDataFromJson(Map<String, dynamic> json) {
  return ChartData(
    state: json['state'] as String,
    count: json['count'] as int,
  );
}

Map<String, dynamic> _$ChartDataToJson(ChartData instance) => <String, dynamic>{
      'state': instance.state,
      'count': instance.count,
    };

RecentBuild _$RecentBuildFromJson(Map<String, dynamic> json) {
  return RecentBuild(
    apk_type: json['apk_type'] as String,
    apk_url: json['apk_url'] as String,
    branch: json['branch'] as String,
    build_end_time: json['build_end_time'] as String,
    build_params: json['build_params'] as String,
    build_start_time: json['build_start_time'] as String,
    commit_id: json['commit_id'] as String,
    commit_message: json['commit_message'] as String,
    create_time: json['create_time'] as String,
    create_user: json['create_user'] as String,
    description: json['description'] as String,
    id: json['id'] as String,
    preview_image: json['preview_image'] as String,
    process: json['process'] as String,
    project_id: json['project_id'] as int,
    server_username: json['server_username'] as String,
    state: json['state'] as String,
    type: json['type'] as String,
    version: json['version'] as String,
    version_code: json['version_code'] as String,
  );
}

Map<String, dynamic> _$RecentBuildToJson(RecentBuild instance) =>
    <String, dynamic>{
      'apk_type': instance.apk_type,
      'apk_url': instance.apk_url,
      'branch': instance.branch,
      'build_end_time': instance.build_end_time,
      'build_params': instance.build_params,
      'build_start_time': instance.build_start_time,
      'commit_id': instance.commit_id,
      'commit_message': instance.commit_message,
      'create_time': instance.create_time,
      'create_user': instance.create_user,
      'description': instance.description,
      'id': instance.id,
      'preview_image': instance.preview_image,
      'process': instance.process,
      'project_id': instance.project_id,
      'server_username': instance.server_username,
      'state': instance.state,
      'type': instance.type,
      'version': instance.version,
      'version_code': instance.version_code,
    };
