import 'package:ruoyi_app/generated/json/base/json_convert_content.dart';
import 'package:ruoyi_app/api/system/data/order/good_entity.dart';

GoodEntity $GoodEntityFromJson(Map<String, dynamic> json) {
  final GoodEntity goodEntity = GoodEntity();
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    goodEntity.msg = msg;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    goodEntity.code = code;
  }
  final List<GoodGoods>? goods = (json['goods'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<GoodGoods>(e) as GoodGoods).toList();
  if (goods != null) {
    goodEntity.goods = goods;
  }
  return goodEntity;
}

Map<String, dynamic> $GoodEntityToJson(GoodEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['msg'] = entity.msg;
  data['code'] = entity.code;
  data['goods'] = entity.goods?.map((v) => v.toJson()).toList();
  return data;
}

extension GoodEntityExtension on GoodEntity {
  GoodEntity copyWith({
    String? msg,
    int? code,
    List<GoodGoods>? goods,
  }) {
    return GoodEntity()
      ..msg = msg ?? this.msg
      ..code = code ?? this.code
      ..goods = goods ?? this.goods;
  }
}

GoodGoods $GoodGoodsFromJson(Map<String, dynamic> json) {
  final GoodGoods goodGoods = GoodGoods();
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    goodGoods.name = name;
  }
  final int? amount = jsonConvert.convert<int>(json['amount']);
  if (amount != null) {
    goodGoods.amount = amount;
  }
  final double? unitPrice = jsonConvert.convert<double>(json['unit_price']);
  if (unitPrice != null) {
    goodGoods.unitPrice = unitPrice;
  }
  final double? totalPrice = jsonConvert.convert<double>(json['total_price']);
  if (totalPrice != null) {
    goodGoods.totalPrice = totalPrice;
  }
  final String? item_currency = jsonConvert.convert<String>(
      json['item_currency']);
  if (item_currency != null) {
    goodGoods.item_currency = item_currency;
  }
  return goodGoods;
}

Map<String, dynamic> $GoodGoodsToJson(GoodGoods entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['name'] = entity.name;
  data['amount'] = entity.amount;
  data['unit_price'] = entity.unitPrice;
  data['total_price'] = entity.totalPrice;
  data['item_currency'] = entity.item_currency;
  return data;
}

extension GoodGoodsExtension on GoodGoods {
  GoodGoods copyWith({
    String? name,
    int? amount,
    double? unitPrice,
    double? totalPrice,
    String? item_currency,
  }) {
    return GoodGoods()
      ..name = name ?? this.name
      ..amount = amount ?? this.amount
      ..unitPrice = unitPrice ?? this.unitPrice
      ..totalPrice = totalPrice ?? this.totalPrice
      ..item_currency = item_currency ?? this.item_currency;
  }
}
