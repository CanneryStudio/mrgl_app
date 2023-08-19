import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/order_entity.g.dart';
import 'dart:convert';
export 'package:ruoyi_app/generated/json/order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
	int? total;
	List<OrderRows>? rows;
	int? code;
	String? msg;

	OrderEntity();

	factory OrderEntity.fromJson(Map<String, dynamic> json) => $OrderEntityFromJson(json);

	Map<String, dynamic> toJson() => $OrderEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class OrderRows {
	dynamic createBy;
	dynamic createTime;
	dynamic updateBy;
	dynamic updateTime;
	dynamic remark;
	int? orderId;
	String? orderName;
	String? customerName;
	String? salesmanName;
	String? goods;
	String? createData;
	String? lastChangeData;
	int? paymentSchedule;
	String? totalPrices;
	String? currencyType;
	int? confirm;
	int? stateID;
	bool? adminConfirm;

	OrderRows();

	factory OrderRows.fromJson(Map<String, dynamic> json) => $OrderRowsFromJson(json);

	Map<String, dynamic> toJson() => $OrderRowsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}