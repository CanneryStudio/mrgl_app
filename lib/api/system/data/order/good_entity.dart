import 'package:ruoyi_app/generated/json/base/json_field.dart';
import 'package:ruoyi_app/generated/json/good_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class GoodEntity {
	String? msg;
	int? code;
	List<GoodGoods>? goods;

	GoodEntity();

	factory GoodEntity.fromJson(Map<String, dynamic> json) => $GoodEntityFromJson(json);

	Map<String, dynamic> toJson() => $GoodEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class GoodGoods {
	String? name;
	int? amount;
	@JSONField(name: "unit_price")
	double? unitPrice;
	@JSONField(name: "total_price")
	double? totalPrice;
	@JSONField(name: "item_currency")
	String? item_currency;

	GoodGoods();

	factory GoodGoods.fromJson(Map<String, dynamic> json) => $GoodGoodsFromJson(json);

	Map<String, dynamic> toJson() => $GoodGoodsToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
