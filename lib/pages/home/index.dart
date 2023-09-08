import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ruoyi_app/api/system/data/detailedState/detailedstate_entity.dart';
import 'package:ruoyi_app/api/system/data/order/order_entity.dart';
import 'package:ruoyi_app/pages/filepreview/PdfItem.dart';
import 'package:ruoyi_app/pages/video/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../api/system/data/detailedstate.dart';
import '../../api/system/data/logistic.dart';
import '../../api/system/data/logistics/index.dart' as logistic_api;
import '../../api/system/data/order/good_entity.dart';
import '../../api/system/data/orderending.dart';
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
    return WillPopScope(
      // Prevent users from popping this screen unintentionally
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(
                S.current.dingdanliebiao,
                style: const TextStyle(color: Colors.white),
              ),
              // Add more elements like icons, buttons, etc.
              const Spacer(), // Push the search icon to the end
            ],
          ),
          backgroundColor: Colors.blue,
          leading: Container(),
          titleSpacing: 0, // Align title to the left
        ),
        body: RefreshIndicator(
          onRefresh: fetchOrder,
          child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              OrderRows row = orders[index];
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long),
                    // An icon at the start
                    title: Text(
                      "${row.orderName}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    // An icon at the end
                    onTap: () {
                      // Navigate to the order detail page when the list item is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(order: row),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
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
  final List<String> _videos = <String>[];
  final List<String> _files = <String>[];
  final GlobalKey _photoViewGalleryKey = GlobalKey();
  final orderEndingController = TextEditingController();
  String feedBack = '';

  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

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
    String message =
        response.data['statusText'] ?? S.current.orderConfirmed;
    futureLogistics = fetchLogistics();
    futureDetailedState = fetchDetailedState();
    futureGoods = fetchGood();

    Get.snackbar("Tips:", message);
    setState(() {
      widget.order.confirm = 1;
    });
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
      _detailedStates.clear();
      _images.clear();
      _videos.clear();
      _files.clear();
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
            if (value.video != null && value.video is String) {
              String videoStr = value.video as String;
              if (videoStr.contains(',')) {
                var videos = videoStr.split(',');
                for (var vid in videos) {
                  if (vid.endsWith('.mp4')) {
                    var video = DioConfig.baseURL + vid;
                    print("视频：$video");
                    _videos.add(video);
                  }
                  if (vid.endsWith('.pdf') ||
                      vid.endsWith('doc') ||
                      vid.endsWith('.docx') ||
                      vid.endsWith('xlsx') ||
                      vid.endsWith('xls')) {
                    var video = DioConfig.baseURL + vid;
                    print("文件：$video");
                    _files.add(video);
                  }
                }
              } else if (videoStr.endsWith('.mp4')) {
                _videos.add(DioConfig.baseURL + videoStr);
              } else if (videoStr.endsWith('.pdf')) {
                _files.add(DioConfig.baseURL + videoStr);
              }
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

  Future<void> sendOrderEnding() async {
    try {
      await submitEndingRemarkByCustomer(jsonEncode({
        "orderID": widget.order.orderName,
        "customerRemark": orderEndingController.text
      }));
      Get.snackbar("Tips:", S.current.yichenggongtijiaoyiyi);
    } catch (e) {
      Get.snackbar("Tips:", S.current.tijiaoshibai);
    }
  }

  Future<DetailedstateEntity?> _fetchDetailedState(String newStateName) async {
    try {
      var response = await getDetailedStateByOrderId(widget.order.orderId!);
      Map<String, dynamic> map = response.data;
      DetailedstateEntity detailedState = DetailedstateEntity.fromJson(map);
      _detailedStates.clear(); // Clear the list before populating
      _images.clear(); // Clear the list before populating
      _videos.clear();
      _files.clear();
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
            if (value.video != null && value.video is String) {
              String videoStr = value.video as String;
              if (videoStr.contains(',')) {
                var videos = videoStr.split(',');
                for (var vid in videos) {
                  if (vid.endsWith('.mp4')) {
                    print("视频：$vid");
                    _videos.add(DioConfig.baseURL + vid);
                  }
                  if (vid.endsWith('.pdf') ||
                      vid.endsWith('doc') ||
                      vid.endsWith('.docx') ||
                      vid.endsWith('xlsx') ||
                      vid.endsWith('xls')) {
                    var video = DioConfig.baseURL + vid;
                    print("文件：$video");
                    _files.add(video);
                  }
                }
              } else if (videoStr.endsWith('.mp4')) {
                _videos.add(DioConfig.baseURL + videoStr);
              } else if (videoStr.endsWith('.pdf')) {
                _files.add(DioConfig.baseURL + videoStr);
              } else if (videoStr.endsWith('doc') ||
                  videoStr.endsWith('.docx') ||
                  videoStr.endsWith('xlsx') ||
                  videoStr.endsWith('xls')) {
                _files.add(DioConfig.baseURL + videoStr);
              }
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
      body: RefreshIndicator(
        onRefresh: () async {
          futureLogistics = fetchLogistics();
          futureDetailedState = fetchDetailedState();
          futureGoods = fetchGood();
          setState(() {});
        },
        child: ListView(
          children: <Widget>[
            Text(S.current.dingdanxinxi,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Add rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        12.0), // Add rounded corners
                                  ),
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
                                                  good.item_currency
                                                      .toString()),
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
                    // Text(
                    //     '${S.current.zongjia}${widget.order.totalPrices} ${widget.order.currencyType}',
                    //     style: const TextStyle(fontSize: 16)),
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
                    if (roleGroup == "客户")
                      ElevatedButton(
                        onPressed:
                            widget.order.confirm == 0 ? _confirmOrder : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: widget.order.confirm == 0
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(widget.order.confirm == 0
                            ? S.current.querendingdan
                            : S.current.yiqueren),
                      )
                  ],
                ),
              ),
            ),
            Text(
              S.current.wuliuxinxi,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(12.0), // Add rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder<logistic_api.Logistic?>(
                      future: futureLogistics,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text("Error: ${snapshot.error}");
                          }
                          var data = snapshot.data;
                          if (data != null &&
                              data.rows.isNotEmpty &&
                              data.rows[0].dispatch != null &&
                              data.rows[0].track != null &&
                              data.rows[0].dispatch != "" &&
                              data.rows[0].track != "") {
                            logistic_api.Logistic logistics = data;
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
                            return Text(S.of(context).emptywuliu);
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    ),
                    FutureBuilder<DetailedstateEntity?>(
                      future: futureDetailedState,
                      builder: (context, snapshot) {
                        List<Widget> logisticDetails = [];
                        Widget logisticDetail;
                        if (snapshot.hasData &&
                            snapshot.data != null &&
                            snapshot.data!.data!.isNotEmpty) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            }
                            logisticDetails.add(const SizedBox(height: 16));
                            logisticDetails.add(_buildDropdownButton(
                              label: S.current.wuliuzhuangtai,
                              value: _selectedDetailedState,
                              items: _detailedStates,
                              onChanged: (newValue) {
                                onDetailedStateSelected(newValue!);
                              },
                            ));
                            logisticDetails.add(Divider(
                                thickness: 1, color: Colors.grey.shade300));
                            logisticDetails.add(const SizedBox(height: 8));
                            var currentIndex;
                            if (_images.isNotEmpty) {
                              logisticDetails.add(Stack(
                                children: [
                                  SizedBox(
                                    height: 300,
                                    child: PhotoViewGallery.builder(
                                      key: _photoViewGalleryKey,
                                      itemCount: _imageLength,
                                      builder: (context, index) {
                                        return PhotoViewGalleryPageOptions(
                                            imageProvider:
                                                NetworkImage(_images[index]),
                                            minScale: PhotoViewComputedScale
                                                .contained,
                                            maxScale:
                                                PhotoViewComputedScale.covered *
                                                    2,
                                            heroAttributes:
                                                PhotoViewHeroAttributes(
                                                    tag: _images[index]),
                                            onTapUp: (context, details,
                                                controllerValue) {
                                              _showImageDialog(
                                                  context, _images[index]);
                                            });
                                      },
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      backgroundDecoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.grey.shade200,
                                            Colors.grey.shade900
                                          ],
                                        ),
                                      ),
                                      pageController: PageController(),
                                    ),
                                  ),
                                  // 添加一个自定义的指示器
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(
                                        _imageLength,
                                        (index) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: currentIndex == index
                                                ? Colors.blueAccent
                                                : Colors.white.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                            }
                            logisticDetails.add(Divider(
                                thickness: 1, color: Colors.grey.shade300));
                            logisticDetails.add(const SizedBox(height: 16));
                            for (var videoUrl in _videos) {
                              logisticDetails.add(
                                SizedBox(
                                  height: 300, // Set the desired height here
                                  child: ChewieVideoWidget(
                                      videoUrl), // 使用您已有的ChewieVideoWidget
                                ),
                              );
                              logisticDetails.add(const SizedBox(height: 16));
                            }
                            for (var pdfUrl in _files) {
                              logisticDetails.add(
                                SizedBox(
                                  height: 80, // Set the desired height here
                                  child: PdfCard(
                                      fileName: extractOfficeFileName(pdfUrl),
                                      filePath: pdfUrl),
                                ),
                              );
                              logisticDetails.add(const SizedBox(height: 16));
                            }
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
                            logisticDetails.add(const SizedBox(height: 16));
                            logisticDetail = Column(
                              children: logisticDetails,
                            );
                            return logisticDetail;
                          } else {
                            return const CircularProgressIndicator();
                          }
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
            if (roleGroup == '客户' &&
                widget.order.done == false &&
                widget.order.waitingEndConfirm == true)
              ElevatedButton(
                onPressed: () async {
                  var response =
                      await endOrderByCustomer(widget.order.orderId!);
                  if (response.data["code"] == 200) {
                    Get.snackbar("Tips:", "订单已结束");
                    setState(() {
                      widget.order.paymentSchedule = 2;
                      widget.order.waitingEndConfirm = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
                child: Text(S.of(context).querenjieshu),
              )
            //订单结束按钮(已确认)
            else if (roleGroup == '客户' && widget.order.done == true)
              ElevatedButton(
                onPressed: () async {},
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.grey,
                ),
                child: Text(S.of(context).dingdanyijieshu),
              ),
            if (roleGroup == '客户' &&
                widget.order.done == false &&
                widget.order.waitingEndConfirm == true)
              TextField(
                controller: orderEndingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: S.of(context).ruyouyiyi,
                ),
              ),
            if (roleGroup == '客户' &&
                widget.order.done == false &&
                widget.order.waitingEndConfirm == true)
              ElevatedButton(
                onPressed: () {
                  sendOrderEnding();
                },
                child: Text(S.of(context).tijiaoyiyi),
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

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _saveImage(imageUrl);
                    },
                    child: const Text('Save Image'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _saveImage(String imageUrl) async {
    final Uri url = Uri.parse(imageUrl);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  String extractOfficeFileName(String fileUrl) {
    final RegExp regExp = RegExp(r'([^/]+\.(pdf|docx|doc|xlsx|xls))$');
    final Match? match = regExp.firstMatch(fileUrl);

    return match != null ? match.group(1)! : 'UnknownFile';
  }
}
