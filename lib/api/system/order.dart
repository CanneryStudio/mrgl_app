import '../../utils/request.dart';

var getAllOrder = () async =>
    await DioRequest().httpRequest("/system/ordersmanager/list", true, "get");

//确认订单
var confirmOrder = (int orderId) async =>
await DioRequest().httpRequest(
    "/system/ordersmanager/confirmOrder/$orderId", true, "get");
