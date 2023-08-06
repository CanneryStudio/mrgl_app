import '../../../utils/request.dart';

var getSales = () async => await DioRequest().httpRequest("/system/customerManager/list", true, "get");