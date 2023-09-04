import '../../utils/request.dart';

var getAllOrder = () async =>
    await DioRequest().httpRequest("/system/ordersmanager/list", true, "get");

//确认订单
var confirmOrder = (int orderId) async =>
await DioRequest().httpRequest(
    "/system/ordersmanager/confirmOrder/$orderId", true, "get");

var getGoodsByOrderId = (int orderId) async =>
await DioRequest().httpRequest(
    "/system/ordersmanager/getGoods/$orderId", true, "get");

var submitOrder = (data) async =>
await DioRequest().httpRequest(
    "/system/ordersmanager", true, "post", data: data);

var endOrderByCustomer = (orderName) async =>
await DioRequest().httpRequest(
    "/system/ordersmanager/endOrderCustomer/$orderName", true, "post");
