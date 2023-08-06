//查询物流信息
import '../../../utils/request.dart';

var getAllLogistics = () async => await DioRequest().httpRequest("/system/logistics/list", true, "get");

//获得指定订单的物流信息
var getLogisticsByOrderId = (int orderId) async =>
await DioRequest().httpRequest(
    "/system/logistics/listByOrderId/$orderId", true, "get");

