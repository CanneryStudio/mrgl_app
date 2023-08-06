import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/order_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class OrderEntity {
	late int total;
	late List<OrderRows> rows;
	late int code;
	late String msg;

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
	late int orderId;
	late String customerName;
	late String salesmanName;
	late String goods;
	late String createData;
	dynamic lastChangeData;
	late int paymentSchedule;
	late String totalPrices;
	late String currencyType;
	late int confirm;
	late bool adminConfirm;

	OrderRows();

	factory OrderRows.fromJson(Map<String, dynamic> json) => $OrderRowsFromJson(json);

	Map<String, dynamic> toJson() => $OrderRowsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}