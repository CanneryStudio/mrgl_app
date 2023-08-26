//查询物流信息
import '../../../utils/request.dart';

//获得指定订单的物流信息
var getOrderEndingByOrderName = (orderName) async =>
await DioRequest().httpRequest(
    "/system/orderending/selectDetailedOrderStateList/$orderName", true, "get");

var confirmEndingByCustomer = (orderName) async =>
await DioRequest().httpRequest(
    "/system/orderending/confirmOrderEndingByCustomer/$orderName", true, "get");

