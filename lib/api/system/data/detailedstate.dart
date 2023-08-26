//查询物流信息
import '../../../utils/request.dart';
//获得指定订单的物流信息
var getDetailedStateByOrderId = (int orderId) async =>
await DioRequest().httpRequest(
    "/system/detailedState/selectDetailedOrderStateList/$orderId", true, "get");

