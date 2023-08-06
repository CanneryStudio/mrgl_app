import '../../../utils/request.dart';

var getAllCustomerAndSales = () async => await DioRequest().httpRequest("/system/customertable/list", true, "get");