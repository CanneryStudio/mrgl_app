import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/order_entity.g.dart';
import 'dart:convert';
export 'package:ruoyi_app/generated/json/order_entity.g.dart';

@JsonSerializable()
class OrderEntity {
	int? total = 0;
	List<OrderRows>? rows = [];
	int? code = 0;
	String? msg = '';

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
	int? orderId = 0;
	String? orderName = '';
	String? customerName = '';
	String? salesmanName = '';
	String? goods = '';
	String? createData = '';
	String? lastChangeData = '';
	int? paymentSchedule = 0;
	String? totalPrices = '';
	String? currencyType = '';
	int? confirm = 0;
	int? stateID = 0;
	bool? waitingEndConfirm = false;
	bool? done = false;
	bool? adminConfirm = false;

	OrderRows();

	factory OrderRows.fromJson(Map<String, dynamic> json) => $OrderRowsFromJson(json);

	Map<String, dynamic> toJson() => $OrderRowsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
