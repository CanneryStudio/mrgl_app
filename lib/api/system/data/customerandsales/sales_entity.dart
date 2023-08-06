import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/sales_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class SalesEntity {
	int? total;
	List<SalesRows>? rows;
	int? code;
	String? msg;

	SalesEntity();

	factory SalesEntity.fromJson(Map<String, dynamic> json) => $SalesEntityFromJson(json);

	Map<String, dynamic> toJson() => $SalesEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class SalesRows {
	dynamic createBy;
	dynamic createTime;
	dynamic updateBy;
	dynamic updateTime;
	dynamic remark;
	String? customerID;
	String? salesmanID;
	String? createDate;

	SalesRows();

	factory SalesRows.fromJson(Map<String, dynamic> json) => $SalesRowsFromJson(json);

	Map<String, dynamic> toJson() => $SalesRowsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}