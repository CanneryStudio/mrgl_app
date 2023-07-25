// To parse this JSON data, do
//
//     final logistic = logisticFromJson(jsonString);

import 'dart:convert';

Logistic logisticFromJson(String str) => Logistic.fromJson(json.decode(str));

String logisticToJson(Logistic data) => json.encode(data.toJson());


///ApifoxModel
class Logistic {
  Logistic({
    required this.code,
    required this.msg,
    required this.rows,
    required this.total,
  });

  int code;
  String msg;
  List<Row> rows;
  int total;

  factory Logistic.fromJson(Map<String, dynamic> json) =>
      Logistic(
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
    required this.contentGoods,
    this.createBy,
    this.createTime,
    required this.destination,
    required this.dispatch,
    required this.logisticsId,
    required this.orderId,
    required this.progressState,
    this.remark,
    required this.track,
    this.updateBy,
    this.updateTime,
  });

  String contentGoods;
  dynamic createBy;
  dynamic createTime;
  String destination;
  String dispatch;
  int logisticsId;
  int orderId;
  int progressState;
  dynamic remark;
  String track;
  dynamic updateBy;
  dynamic updateTime;

  factory Row.fromJson(Map<String, dynamic> json) =>
      Row(
        contentGoods: json["contentGoods"],
        createBy: json["createBy"],
        createTime: json["createTime"],
        destination: json["destination"],
        dispatch: json["dispatch"],
        logisticsId: json["logisticsId"],
        orderId: json["orderId"],
        progressState: json["progressState"],
        remark: json["remark"],
        track: json["track"],
        updateBy: json["updateBy"],
        updateTime: json["updateTime"],
      );

  Map<String, dynamic> toJson() =>
      {
        "contentGoods": contentGoods,
        "createBy": createBy,
        "createTime": createTime,
        "destination": destination,
        "dispatch": dispatch,
        "logisticsId": logisticsId,
        "orderId": orderId,
        "progressState": progressState,
        "remark": remark,
        "track": track,
        "updateBy": updateBy,
        "updateTime": updateTime,
      };
}
