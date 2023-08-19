import 'package:ruoyi_app/generated/json/base/json_convert_content.dart';
import 'package:ruoyi_app/api/system/data/customerandsales/customer_and_sales_entity.dart';

CustomerAndSalesEntity $CustomerAndSalesEntityFromJson(
    Map<String, dynamic> json) {
  final CustomerAndSalesEntity customerAndSalesEntity = CustomerAndSalesEntity();
  final int? total = jsonConvert.convert<int>(json['total']);
  if (total != null) {
    customerAndSalesEntity.total = total;
  }
  final List<CustomerAndSalesRows>? rows = (json['rows'] as List<dynamic>?)
      ?.map(
          (e) =>
      jsonConvert.convert<CustomerAndSalesRows>(e) as CustomerAndSalesRows)
      .toList();
  if (rows != null) {
    customerAndSalesEntity.rows = rows;
  }
  final int? code = jsonConvert.convert<int>(json['code']);
  if (code != null) {
    customerAndSalesEntity.code = code;
  }
  final String? msg = jsonConvert.convert<String>(json['msg']);
  if (msg != null) {
    customerAndSalesEntity.msg = msg;
  }
  return customerAndSalesEntity;
}

Map<String, dynamic> $CustomerAndSalesEntityToJson(
    CustomerAndSalesEntity entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['total'] = entity.total;
  data['rows'] = entity.rows?.map((v) => v.toJson()).toList();
  data['code'] = entity.code;
  data['msg'] = entity.msg;
  return data;
}

extension CustomerAndSalesEntityExt on CustomerAndSalesEntity {
  CustomerAndSalesEntity copyWith({
    int? total,
    List<CustomerAndSalesRows>? rows,
    int? code,
    String? msg,
  }) {
    return CustomerAndSalesEntity()
      ..total = total ?? this.total
      ..rows = rows ?? this.rows
      ..code = code ?? this.code
      ..msg = msg ?? this.msg;
  }
}

CustomerAndSalesRows $CustomerAndSalesRowsFromJson(Map<String, dynamic> json) {
  final CustomerAndSalesRows customerAndSalesRows = CustomerAndSalesRows();
  final dynamic createBy = json['createBy'];
  if (createBy != null) {
    customerAndSalesRows.createBy = createBy;
  }
  final dynamic createTime = json['createTime'];
  if (createTime != null) {
    customerAndSalesRows.createTime = createTime;
  }
  final dynamic updateBy = json['updateBy'];
  if (updateBy != null) {
    customerAndSalesRows.updateBy = updateBy;
  }
  final dynamic updateTime = json['updateTime'];
  if (updateTime != null) {
    customerAndSalesRows.updateTime = updateTime;
  }
  final dynamic remark = json['remark'];
  if (remark != null) {
    customerAndSalesRows.remark = remark;
  }
  final int? customerID = jsonConvert.convert<int>(json['customerID']);
  if (customerID != null) {
    customerAndSalesRows.customerID = customerID;
  }
  final int? salesmanID = jsonConvert.convert<int>(json['salesmanID']);
  if (salesmanID != null) {
    customerAndSalesRows.salesmanID = salesmanID;
  }
  final String? createDate = jsonConvert.convert<String>(json['createDate']);
  if (createDate != null) {
    customerAndSalesRows.createDate = createDate;
  }
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    customerAndSalesRows.id = id;
  }
  return customerAndSalesRows;
}

Map<String, dynamic> $CustomerAndSalesRowsToJson(CustomerAndSalesRows entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['createBy'] = entity.createBy;
  data['createTime'] = entity.createTime;
  data['updateBy'] = entity.updateBy;
  data['updateTime'] = entity.updateTime;
  data['remark'] = entity.remark;
  data['customerID'] = entity.customerID;
  data['salesmanID'] = entity.salesmanID;
  data['createDate'] = entity.createDate;
  data['id'] = entity.id;
  return data;
}

extension CustomerAndSalesRowsExt on CustomerAndSalesRows {
  CustomerAndSalesRows copyWith({
    dynamic createBy,
    dynamic createTime,
    dynamic updateBy,
    dynamic updateTime,
    dynamic remark,
    int? customerID,
    int? salesmanID,
    String? createDate,
    int? id,
  }) {
    return CustomerAndSalesRows()
      ..createBy = createBy ?? this.createBy
      ..createTime = createTime ?? this.createTime
      ..updateBy = updateBy ?? this.updateBy
      ..updateTime = updateTime ?? this.updateTime
      ..remark = remark ?? this.remark
      ..customerID = customerID ?? this.customerID
      ..salesmanID = salesmanID ?? this.salesmanID
      ..createDate = createDate ?? this.createDate
      ..id = id ?? this.id;
  }
}