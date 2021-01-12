part of domain;

/// 项目详细信息
@JsonSerializable()
class ProjectDetail {
  List<ChartData> chartData;
  List<RecentBuild> recentBuild;

  ProjectDetail({
    this.chartData,
    this.recentBuild,
  });

  factory ProjectDetail.fromJson(Map<String, dynamic> json) => _$ProjectDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectDetailToJson(this);

  @override
  String toString() {
    return json.encode(this);
  }
}

/// 项目图表信息
@JsonSerializable()
class ChartData {
  String state;
  int count;

  ChartData({
    this.state,
    this.count,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) => _$ChartDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChartDataToJson(this);

  @override
  String toString() {
    return json.encode(this);
  }

  String get stateDesc {
    switch (state) {
      case 'success':
        return '成功';
      case 'error':
        return '失败';
      case 'userstop':
        return '终止';
      default:
        return '未知';
    }
  }
}

/// 项目最近构建信息
@JsonSerializable()
class RecentBuild {
  String apk_type;
  String apk_url;
  String branch;
  String build_end_time;
  String build_params;
  String build_start_time;
  String commit_id;
  String commit_message;
  String create_time;
  String create_user;
  String description;
  String id;
  String preview_image;
  String process;
  int project_id;
  String server_username;
  String state;
  String type;
  String version;
  String version_code;

  RecentBuild({
    this.apk_type,
    this.apk_url,
    this.branch,
    this.build_end_time,
    this.build_params,
    this.build_start_time,
    this.commit_id,
    this.commit_message,
    this.create_time,
    this.create_user,
    this.description,
    this.id,
    this.preview_image,
    this.process,
    this.project_id,
    this.server_username,
    this.state,
    this.type,
    this.version,
    this.version_code,
  });

  factory RecentBuild.fromJson(Map<String, dynamic> json) => _$RecentBuildFromJson(json);

  Map<String, dynamic> toJson() => _$RecentBuildToJson(this);

  @override
  String toString() {
    return json.encode(this);
  }
}
