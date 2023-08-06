import 'package:ruoyi_app/generated/json/base/json_convert_content.dart';
import 'package:ruoyi_app/api/system/data/order/order_entity.dart';

OrderEntity $OrderEntityFromJson(Map<String, dynamic> json) {
  final OrderEntity orderEntity = OrderEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    orderEntity.total = total;
  }
  final List<OrderRows>? rows = (json['rows'] as List<dynamic>).map(
          (e) => jsonConvert.convert<OrderRows>(e) as OrderRows).toList();
  if (rows != null) {
    orderEntity.rows = rows;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    orderEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    orderEntity.msg = msg;
  }
  return orderEntity;
}

Map<String, dynamic> $OrderEntityToJson(OrderEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['rows'] = entity.rows.map((v) => v.toJson()).toList();
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  return data;
}

OrderRows $OrderRowsFromJson(Map<String, dynamic> json) {
  final OrderRows orderRows = OrderRows();
  final dynamic createBy = json['createBy'];
  if (createBy != null) {
    orderRows.createBy = createBy;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    orderRows.createTime = createTime;
  }
  final dynamic updateBy = json['updateBy'];
  if (updateBy != null) {
    orderRows.updateBy = updateBy;
  }
  final dynamic updateTime = json['updateTime'];
  if (updateTime != null) {
    orderRows.updateTime = updateTime;
  }
  final dynamic remark = json['remark'];
  if (remark != null) {
    orderRows.remark = remark;
  }
  final int? orderId = jsonConvert.convert<int>(json['orderId']);
  if (orderId != null) {
    orderRows.orderId = orderId;
  }
  final String? customerName = jsonConvert.convert<String>(
      json['customerName']);
  if (customerName != null) {
    orderRows.customerName = customerName;
  }
  final String? salesmanName = jsonConvert.convert<String>(
      json['salesmanName']);
  if (salesmanName != null) {
    orderRows.salesmanName = salesmanName;
  }
  final String? goods = jsonConvert.convert<String>(json['goods']);
  if (goods != null) {
    orderRows.goods = goods;
  }
  final String? createData = jsonConvert.convert<String>(json['createData']);
  if (createData != null) {
    orderRows.createData = createData;
  }
  final dynamic lastChangeData = json['lastChangeData'];
  if (lastChangeData != null) {
    orderRows.lastChangeData = lastChangeData;
  }
  final int? paymentSchedule = jsonConvert.convert<int>(
      json['paymentSchedule']);
  if (paymentSchedule != null) {
    orderRows.paymentSchedule = paymentSchedule;
  }
  final String? totalPrices = jsonConvert.convert<String>(json['totalPrices']);
  if (totalPrices != null) {
    orderRows.totalPrices = totalPrices;
  }
  final String? currencyType = jsonConvert.convert<String>(
      json['currencyType']);
  if (currencyType != null) {
    orderRows.currencyType = currencyType;
  }
  final int? confirm = jsonConvert.convert<int>(json['confirm']);
  if (confirm != null) {
    orderRows.confirm = confirm;
  }
  final bool? adminConfirm = jsonConvert.convert<bool>(json['adminConfirm']);
  if (adminConfirm != null) {
    orderRows.adminConfirm = adminConfirm;
  }
  return orderRows;
}

Map<String, dynamic> $OrderRowsToJson(OrderRows entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createBy'] = entity.createBy;
  data['createTime'] = entity.createTime;
  data['updateBy'] = entity.updateBy;
  data['updateTime'] = entity.updateTime;
  data['remark'] = entity.remark;
  data['orderId'] = entity.orderId;
  data['customerName'] = entity.customerName;
  data['salesmanName'] = entity.salesmanName;
  data['goods'] = entity.goods;
  data['createData'] = entity.createData;
  data['lastChangeData'] = entity.lastChangeData;
  data['paymentSchedule'] = entity.paymentSchedule;
  data['totalPrices'] = entity.totalPrices;
  data['currencyType'] = entity.currencyType;
  data['confirm'] = entity.confirm;
  data['adminConfirm'] = entity.adminConfirm;
  return data;
}