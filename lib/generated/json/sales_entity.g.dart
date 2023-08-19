import 'package:ruoyi_app/generated/json/base/json_convert_content.dart';
import 'package:ruoyi_app/api/system/data/customerandsales/sales_entity.dart';

SalesEntity $SalesEntityFromJson(Map<String, dynamic> json) {
  final SalesEntity salesEntity = SalesEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    salesEntity.total = total;
  }
  final List<SalesRows>? rows = (json['rows'] as List<dynamic>?)?.map(
          (e) => jsonConvert.convert<SalesRows>(e) as SalesRows).toList();
  if (rows != null) {
    salesEntity.rows = rows;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    salesEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    salesEntity.msg = msg;
  }
  return salesEntity;
}

Map<String, dynamic> $SalesEntityToJson(SalesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['rows'] = entity.rows?.map((v) => v.toJson()).toList();
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  return data;
}

extension SalesEntityExt on SalesEntity {
  SalesEntity copyWith({
    int? total,
    List<SalesRows>? rows,
    int? code,
    String? msg,
  }) {
    return SalesEntity()
      ..total = total ?? this.total
      ..rows = rows ?? this.rows
      ..code = code ?? this.code
      ..msg = msg ?? this.msg;
  }
}

SalesRows $SalesRowsFromJson(Map<String, dynamic> json) {
  final SalesRows salesRows = SalesRows();
  final dynamic createBy = json['createBy'];
  if (createBy != null) {
    salesRows.createBy = createBy;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    salesRows.createTime = createTime;
  }
  final dynamic updateBy = json['updateBy'];
  if (updateBy != null) {
    salesRows.updateBy = updateBy;
  }
  final dynamic updateTime = json['updateTime'];
  if (updateTime != null) {
    salesRows.updateTime = updateTime;
  }
  final dynamic remark = json['remark'];
  if (remark != null) {
    salesRows.remark = remark;
  }
  final String? customerID = jsonConvert.convert<String>(json['customerID']);
  if (customerID != null) {
    salesRows.customerID = customerID;
  }
  final String? salesmanID = jsonConvert.convert<String>(json['salesmanID']);
  if (salesmanID != null) {
    salesRows.salesmanID = salesmanID;
  }
  final String? createDate = jsonConvert.convert<String>(json['createDate']);
  if (createDate != null) {
    salesRows.createDate = createDate;
  }
  return salesRows;
}

Map<String, dynamic> $SalesRowsToJson(SalesRows entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createBy'] = entity.createBy;
  data['createTime'] = entity.createTime;
  data['updateBy'] = entity.updateBy;
  data['updateTime'] = entity.updateTime;
  data['remark'] = entity.remark;
  data['customerID'] = entity.customerID;
  data['salesmanID'] = entity.salesmanID;
  data['createDate'] = entity.createDate;
  return data;
}

extension SalesRowsExt on SalesRows {
  SalesRows copyWith({
    dynamic createBy,
    dynamic createTime,
    dynamic updateBy,
    dynamic updateTime,
    dynamic remark,
    String? customerID,
    String? salesmanID,
    String? createDate,
  }) {
    return SalesRows()
      ..createBy = createBy ?? this.createBy
      ..createTime = createTime ?? this.createTime
      ..updateBy = updateBy ?? this.updateBy
      ..updateTime = updateTime ?? this.updateTime
      ..remark = remark ?? this.remark
      ..customerID = customerID ?? this.customerID
      ..salesmanID = salesmanID ?? this.salesmanID
      ..createDate = createDate ?? this.createDate;
  }
}