import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/detailedstate_entity.g.dart';
import 'dart:convert';
export 'package:ruoyi_app/generated/json/detailedstate_entity.g.dart';

@JsonSerializable()
class DetailedstateEntity {
	String? msg = '';
	int? code = 0;
	List<DetailedstateData>? data = [];

	DetailedstateEntity();

	factory DetailedstateEntity.fromJson(Map<String, dynamic> json) => $DetailedstateEntityFromJson(json);

	Map<String, dynamic> toJson() => $DetailedstateEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class DetailedstateData {
	dynamic createBy;
	dynamic createTime;
	dynamic updateBy;
	dynamic updateTime;
	dynamic remark;
	int? id = 0;
	int? orderID = 0;
	String? stateName = '';
	String? stateDesc = '';
	String? stateImage = '';
	dynamic video;

	DetailedstateData();

	factory DetailedstateData.fromJson(Map<String, dynamic> json) => $DetailedstateDataFromJson(json);

	Map<String, dynamic> toJson() => $DetailedstateDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
