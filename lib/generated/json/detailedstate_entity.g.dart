import 'package:ruoyi_app/generated/json/base/json_convert_content.dart';
import 'package:ruoyi_app/api/system/data/detailedState/detailedstate_entity.dart';

DetailedstateEntity $DetailedstateEntityFromJson(Map<String, dynamic> json) {
  final DetailedstateEntity detailedstateEntity = DetailedstateEntity();
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    detailedstateEntity.msg = msg;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    detailedstateEntity.code = code;
  }
  final List<DetailedstateData>? data = (json['data'] as List<dynamic>?)
      ?.map(
          (e) => jsonConvert.convert<DetailedstateData>(e) as DetailedstateData)
      .toList();
  if (data != null) {
    detailedstateEntity.data = data;
  }
  return detailedstateEntity;
}

Map<String, dynamic> $DetailedstateEntityToJson(DetailedstateEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msg'] = entity.msg;
  data['code'] = entity.code;
  data['data'] = entity.data?.map((v) => v.toJson()).toList();
  return data;
}

extension DetailedstateEntityExtension on DetailedstateEntity {
  DetailedstateEntity copyWith({
    String? msg,
    int? code,
    List<DetailedstateData>? data,
  }) {
    return DetailedstateEntity()
      ..msg = msg ?? this.msg
      ..code = code ?? this.code
      ..data = data ?? this.data;
  }
}

DetailedstateData $DetailedstateDataFromJson(Map<String, dynamic> json) {
  final DetailedstateData detailedstateData = DetailedstateData();
  final dynamic createBy = json['createBy'];
  if (createBy != null) {
    detailedstateData.createBy = createBy;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    detailedstateData.createTime = createTime;
  }
  final dynamic updateBy = json['updateBy'];
  if (updateBy != null) {
    detailedstateData.updateBy = updateBy;
  }
  final dynamic updateTime = json['updateTime'];
  if (updateTime != null) {
    detailedstateData.updateTime = updateTime;
  }
  final dynamic remark = json['remark'];
  if (remark != null) {
    detailedstateData.remark = remark;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    detailedstateData.id = id;
  }
  final int? orderID = jsonConvert.convert<int>(json['orderID']);
  if (orderID != null) {
    detailedstateData.orderID = orderID;
  }
  final String? stateName = jsonConvert.convert<String>(json['stateName']);
  if (stateName != null) {
    detailedstateData.stateName = stateName;
  }
  final String? stateDesc = jsonConvert.convert<String>(json['stateDesc']);
  if (stateDesc != null) {
    detailedstateData.stateDesc = stateDesc;
  }
  final String? stateImage = jsonConvert.convert<String>(json['stateImage']);
  if (stateImage != null) {
    detailedstateData.stateImage = stateImage;
  }
  final dynamic video = json['video'];
  if (video != null) {
    detailedstateData.video = video;
  }
  return detailedstateData;
}

Map<String, dynamic> $DetailedstateDataToJson(DetailedstateData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createBy'] = entity.createBy;
  data['createTime'] = entity.createTime;
  data['updateBy'] = entity.updateBy;
  data['updateTime'] = entity.updateTime;
  data['remark'] = entity.remark;
  data['id'] = entity.id;
  data['orderID'] = entity.orderID;
  data['stateName'] = entity.stateName;
  data['stateDesc'] = entity.stateDesc;
  data['stateImage'] = entity.stateImage;
  data['video'] = entity.video;
  return data;
}

extension DetailedstateDataExtension on DetailedstateData {
  DetailedstateData copyWith({
    dynamic createBy,
    dynamic createTime,
    dynamic updateBy,
    dynamic updateTime,
    dynamic remark,
    int? id,
    int? orderID,
    String? stateName,
    String? stateDesc,
    String? stateImage,
    dynamic video,
  }) {
    return DetailedstateData()
      ..createBy = createBy ?? this.createBy
      ..createTime = createTime ?? this.createTime
      ..updateBy = updateBy ?? this.updateBy
      ..updateTime = updateTime ?? this.updateTime
      ..remark = remark ?? this.remark
      ..id = id ?? this.id
      ..orderID = orderID ?? this.orderID
      ..stateName = stateName ?? this.stateName
      ..stateDesc = stateDesc ?? this.stateDesc
      ..stateImage = stateImage ?? this.stateImage
      ..video = video ?? this.video;
  }
}
