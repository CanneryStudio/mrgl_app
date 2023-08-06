import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/customer_and_sales_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class CustomerAndSalesEntity {
	int? total;
	List<CustomerAndSalesRows>? rows;
	int? code;
	String? msg;

	CustomerAndSalesEntity();

	factory CustomerAndSalesEntity.fromJson(Map<String, dynamic> json) => $CustomerAndSalesEntityFromJson(json);

	Map<String, dynamic> toJson() => $CustomerAndSalesEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class CustomerAndSalesRows {
	dynamic createBy;
	dynamic createTime;
	dynamic updateBy;
	dynamic updateTime;
	dynamic remark;
	int? customerID;
	int? salesmanID;
	String? createDate;
	int? id;

	CustomerAndSalesRows();

	factory CustomerAndSalesRows.fromJson(Map<String, dynamic> json) => $CustomerAndSalesRowsFromJson(json);

	Map<String, dynamic> toJson() => $CustomerAndSalesRowsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}