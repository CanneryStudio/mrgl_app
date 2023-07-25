// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());


class Order {
  Order({
    required this.code,
    required this.msg,
    required this.rows,
    required this.total,
  });

  int code;
  String msg;
  List<Row> rows;
  int total;

  factory Order.fromJson(Map<String, dynamic> json) =>
      Order(
        code: json["code"],
        msg: json["msg"],
        rows: List<Row>.from(json["rows"].map((x) => Row.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() =>
      {
        "code": code,
        "msg": msg,
        "rows": List<dynamic>.from(rows.map((x) => x.toJson())),
        "total": total,
      };
}

class Row {
  Row({
    required this.confirm,
    this.createBy,
    required this.createData,
    this.createTime,
    required this.customerName,
    required this.goods,
    this.lastChangeData,
    required this.orderId,
    required this.paymentSchedule,
    this.remark,
    required this.salesmanName,
    required this.totalPrices,
    this.updateBy,
    this.updateTime,
  });

  int confirm;
  dynamic createBy;
  String createData;
  dynamic createTime;
  String customerName;
  String goods;
  dynamic lastChangeData;
  int orderId;
  int paymentSchedule;
  dynamic remark;
  String salesmanName;
  String totalPrices;
  dynamic updateBy;
  dynamic updateTime;

  factory Row.fromJson(Map<String, dynamic> json) =>
      Row(
        confirm: json["confirm"],
        createBy: json["createBy"],
        createData: json["createData"],
        createTime: json["createTime"],
        customerName: json["customerName"],
        goods: json["goods"],
        lastChangeData: json["lastChangeData"],
        orderId: json["orderId"],
        paymentSchedule: json["paymentSchedule"],
        remark: json["remark"],
        salesmanName: json["salesmanName"],
        totalPrices: json["totalPrices"],
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() =>
      {
        "confirm": confirm,
        "createBy": createBy,
        "createData": createData,
        "createTime": createTime,
        "customerName": customerName,
        "goods": goods,
        "lastChangeData": lastChangeData,
        "orderId": orderId,
        "paymentSchedule": paymentSchedule,
        "remark": remark,
        "salesmanName": salesmanName,
        "totalPrices": totalPrices,
        "updateBy": updateBy,
        "updateTime": updateTime,
      };
}
