import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ruoyi_app/api/system/data/detailedState/detailedstate_entity.dart';
import 'package:ruoyi_app/api/system/data/order/order_entity.dart';

import '../../api/system/data/detailedstate.dart';
import '../../api/system/data/logistic.dart';
import '../../api/system/data/logistics/index.dart' as logistic_api;
import '../../api/system/data/order/good_entity.dart';
import '../../api/system/order.dart';
import '../../generated/l10n.dart';
import '../../utils/request.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  List<OrderRows> orders = [];

  Future<void> fetchOrder() async {
    var response = await getAllOrder();
    Map<String, dynamic> map = response.data;
    OrderEntity order = OrderEntity.fromJson(map);
    orders = List<OrderRows>.from(order.rows!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.dingdanliebiao,
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: fetchOrder,
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            OrderRows row = orders[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text("${row.orderName}",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  // 当用户点击列表项时，跳转到订单详情页
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(order: row),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderDetailPage extends StatefulWidget {
  late Future<logistic_api.Logistic> futureLogistics;
  late Future<List<GoodGoods>> futureGoods;
  final OrderRows order;

  OrderDetailPage({super.key, required this.order});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<logistic_api.Logistic?> futureLogistics;
  late Future<DetailedstateEntity?> futureDetailedState;
  late Future<GoodEntity> goodEntities;
  late Future<List<GoodGoods>> futureGoods;
  String _selectedDetailedState = '';
  String _detailedStateDescription = '';

  final List<String> _detailedStates = <String>[];
  final List<String> _images = <String>[];
  final GlobalKey _photoViewGalleryKey = GlobalKey();

  var _imageLength = 0;

  @override
  void initState() {
    super.initState();
    futureLogistics = fetchLogistics();
    futureDetailedState = fetchDetailedState();
    futureGoods = fetchGood();
  }

  void _confirmOrder() async {
    var response = await confirmOrder(widget.order.orderId!);
    String message = response.data['statusText'] ?? 'Order confirmed!';
    futureLogistics = fetchLogistics();
    initState();
    Get.snackbar("Tips:", message);
  }

  Future<logistic_api.Logistic?> fetchLogistics() async {
    try {
      var response = await getLogisticsByOrderId(widget.order.orderId!);
      Map<String, dynamic> map = response.data;
      logistic_api.Logistic logistics = logistic_api.Logistic.fromJson(map);
      return logistics;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<DetailedstateEntity?> fetchDetailedState() async {
    try {
      var response = await getDetailedStateByOrderId(widget.order.orderId!);
      Map<String, dynamic> map = response.data;
      DetailedstateEntity detailedState = DetailedstateEntity.fromJson(map);
      _detailedStates.clear(); // Clear the list before populating
      _images.clear(); // Clear the list before populating
      _selectedDetailedState = detailedState.data![0].stateName!;
      if (detailedState.data != null) {
        for (var value in detailedState.data!) {
          _detailedStates.add(value.stateName!);
          if (value.stateName == _selectedDetailedState) {
            if (value.stateImage!.contains(',')) {
              var images = value.stateImage!.split(',');
              for (var img in images) {
                _images.add(DioConfig.baseURL + img);
              }
            } else {
              _images.add(DioConfig.baseURL + value.stateImage!);
            }
          }
        }
      }
      _imageLength = _images.length;
      _detailedStateDescription = detailedState.data![0].stateDesc!;
      return detailedState;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  Future<DetailedstateEntity?> _fetchDetailedState(String newStateName) async {
    try {
      var response = await getDetailedStateByOrderId(widget.order.orderId!);
      Map<String, dynamic> map = response.data;
      DetailedstateEntity detailedState = DetailedstateEntity.fromJson(map);
      _detailedStates.clear(); // Clear the list before populating
      _images.clear(); // Clear the list before populating
      _selectedDetailedState = newStateName;
      if (detailedState.data != null) {
        for (var value in detailedState.data!) {
          _detailedStates.add(value.stateName!);
          if (value.stateName == _selectedDetailedState) {
            if (value.stateImage!.contains(',')) {
              var images = value.stateImage!.split(',');
              for (var img in images) {
                _images.add(DioConfig.baseURL + img);
              }
            } else {
              _images.add(DioConfig.baseURL + value.stateImage!);
            }
          }
        }
      }
      _imageLength = _images.length;
      for (var element in detailedState.data!) {
        if (element.stateName == newStateName) {
          _detailedStateDescription = element.stateDesc!;
        }
      }
      return detailedState;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  void onDetailedStateSelected(String newStateName) async {
    setState(() {
      _selectedDetailedState = newStateName;
    });
    futureDetailedState = _fetchDetailedState(newStateName);
  }

  //拉取所有商品信息
  Future<List<GoodGoods>> fetchGood() async {
    var goods = List<GoodGoods>.empty(growable: true);
    try {
      var response = await getGoodsByOrderId(widget.order.orderId!);
      if (kDebugMode) {
        print("订单号：${widget.order.orderId}");
      }
      var goodsData = jsonDecode(response.data['goods']);
      if (goodsData is List) {
        for (var value in goodsData) {
          var good = GoodGoods.fromJson(value);
          goods.add(good);
        }
      }
      if (kDebugMode) {
        print(goods.length);
      }
      if (kDebugMode) {
        print(goods);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      goods = [];
    }
    return goods;
  }

  @override
  Widget build(BuildContext context) {
    var roleGroup = GetStorage().read("roleGroup") ?? "";
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.dingdanxiangqing,
            style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(S.current.dingdanxinxi,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (roleGroup != "客户")
                      Text('${S.current.dingdanhao}${widget.order.orderId}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    if (roleGroup != "客户") const SizedBox(height: 8),
                    //客户名称
                    if (roleGroup != "客户")
                      Text('${S.current.kehu}${widget.order.customerName}',
                          style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    if (roleGroup != "客户" && roleGroup != "销售")
                      Text(
                          '${S.current.xiaoshouyuan}${widget.order.salesmanName}',
                          style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                        '${S.current.chuangjianshijian} ${widget.order.createData}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    //是否确认
                    if (roleGroup != "客户")
                      if (widget.order.confirm == 0 &&
                          widget.order.adminConfirm == true)
                        Text(S.current.shifouqueren + S.current.weiqueren,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                    if (roleGroup != "客户")
                      if (widget.order.confirm == 1 &&
                          widget.order.adminConfirm == true)
                        Text(S.current.shifouqueren + S.current.yiqueren,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    FutureBuilder<List<GoodGoods>>(
                      future: futureGoods,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<GoodGoods>> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // show a loading spinner while waiting
                        } else if (snapshot.hasError) {
                          return Text(
                              'Error: ${snapshot.error}'); // if there is an error, display it
                        } else {
                          List<GoodGoods> goods = snapshot.data!;
                          return ListView.separated(
                            itemCount: goods.length,
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(color: Colors.grey),
                            itemBuilder: (context, index) {
                              GoodGoods good = goods[index];
                              if (kDebugMode) {
                                print(good);
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                child: Card(
                                  elevation: 5,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    leading: const Icon(Icons.shopping_bag,
                                        color: Colors.blue, size: 30),
                                    title: Text(
                                      S.of(context).goodNameGoodname.replaceAll(
                                          "\${good.name!}", good.name!),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 18),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                          S
                                              .of(context)
                                              .shangpinxinxi
                                              .replaceAll('{good.amount}',
                                                  good.amount.toString())
                                              .replaceAll("{good.unitPrice}",
                                                  good.unitPrice.toString())
                                              .replaceAll("{good.totalPrice}",
                                                  good.totalPrice.toString())
                                              .replaceAll(
                                                  "{widget.order.currencyType}",
                                                  widget.order.currencyType!),
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16)),
                                    ),
                                    tileColor: Colors.white,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                        '${S.current.zongjia}${widget.order.totalPrices} ${widget.order.currencyType}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    //订单进度
                    if (roleGroup != "客户")
                      if (widget.order.paymentSchedule == 0)
                        Text(S.current.dingdanjindu + S.current.weifukuan,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                    if (roleGroup != "客户")
                      if (widget.order.paymentSchedule == 1)
                        Text(S.current.dingdanjindu + S.current.yifukuan,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                    if (roleGroup != "客户")
                      if (widget.order.paymentSchedule == 2)
                        Text(S.current.dingdanjindu + S.current.yiwancheng,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                    if (roleGroup == "客户" && widget.order.confirm == 0)
                      ElevatedButton(
                        onPressed: _confirmOrder,
                        child: Text(S.current.querendingdan),
                      ),
                    if (roleGroup == "客户" && widget.order.confirm == 1)
                      ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: Colors.grey,
                        ),
                        child: Text(S.current.yiqueren),
                      ),
                  ],
                ),
              ),
            ),
            Text(
              S.current.wuliuxinxi,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (futureLogistics != null)
              Card(
                margin: const EdgeInsets.all(16.0),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<logistic_api.Logistic?>(
                        future: futureLogistics,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }
                            logistic_api.Logistic logistics = snapshot.data!;
                            return Column(
                              children: logistics.rows.map<Widget>((row) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(S.current.fahuodi + row.dispatch!,
                                          style: const TextStyle(fontSize: 16)),
                                      const SizedBox(height: 16),
                                      Text(S.current.genzong + row.track!,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      if (futureDetailedState.isBlank == false)
                        FutureBuilder<DetailedstateEntity?>(
                          future: futureDetailedState,
                          builder: (context, snapshot) {
                            List<Widget> logisticDetails =
                                []; //先建一个数组用于存放循环生成的widget
                            Widget logisticDetail;
                            var data = snapshot.data;
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Text("Error: ${snapshot.error}");
                              }
                              DetailedstateEntity detailedState =
                                  snapshot.data!;
                              var data = detailedState.data;
                              logisticDetails.add(const SizedBox(height: 16));
                              logisticDetails.add(_buildDropdownButton(
                                label: S.current.wuliuzhuangtai,
                                value: _selectedDetailedState,
                                items: _detailedStates,
                                onChanged: (newValue) {
                                  onDetailedStateSelected(newValue!);
                                },
                              ));
                              logisticDetails.add(const SizedBox(height: 8));
                              logisticDetails.add(
                                SizedBox(
                                  height: 300, // Set the desired height here
                                  child: PhotoViewGallery.builder(
                                    key: _photoViewGalleryKey,
                                    itemCount: _imageLength,
                                    builder: (context, index) {
                                      return PhotoViewGalleryPageOptions(
                                        imageProvider:
                                            NetworkImage(_images[index]),
                                        minScale:
                                            PhotoViewComputedScale.contained,
                                        maxScale:
                                            PhotoViewComputedScale.covered * 2,
                                        heroAttributes: PhotoViewHeroAttributes(
                                            tag: _images[index]),
                                      );
                                    },
                                    scrollPhysics:
                                        const BouncingScrollPhysics(),
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    pageController: PageController(),
                                  ),
                                ),
                              );
                              if (_detailedStateDescription != "") {
                                logisticDetails.add(Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    // Set alignment to left
                                    child: Text(
                                      "${S.current.wuliuxinxi}: $_detailedStateDescription",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ));
                              }
                              //状态描述
                              logisticDetail = Column(
                                children: logisticDetails,
                              );
                              return logisticDetail;
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          onChanged: onChanged,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
