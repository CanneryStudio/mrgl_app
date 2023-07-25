import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/system/data/logistic.dart';
import '../../api/system/data/order/order.dart' as order_api;
import '../../api/system/order.dart';
import '../../api/system/data/logistics/index.dart' as logistic_api;
import '../../api/system/data/logistics/index.dart';
import '../../generated/l10n.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  List<order_api.Row> orders = [];

  Future<void> fetchOrder() async {
    // 调用 getAllOrder 函数获取所有订单的数据
    var response = await getAllOrder();

    // 从 Response 对象中提取出 Map 对象
    Map<String, dynamic> map = response.data;

    // 解析获取到的 Map 对象，将其转换为 "Order" 对象
    order_api.Order order = order_api.Order.fromJson(map);

    // 将 "order.rows" 赋值给 "orders"
    orders = order.rows;

    // 更新页面
    setState(() {});

    print("order:$order");
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
        title: Text(S.of(context).dingdanliebiao,
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: RefreshIndicator(
        onRefresh: fetchOrder,
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            order_api.Row row = orders[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(S.of(context).dingdanhao + "${row.orderId}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
  final order_api.Row order;
  late Future<logistic_api.Logistic> futureLogistics;

  OrderDetailPage({required this.order});

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late Future<logistic_api.Logistic> futureLogistics;

  @override
  void initState() {
    super.initState();
    futureLogistics = fetchLogistics();
  }

  void _confirmOrder() async {
    var response = await confirmOrder(widget.order.orderId);
    String message = response.data['statusText'] ?? 'Order confirmed!';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<logistic_api.Logistic> fetchLogistics() async {
    var response = await getLogisticsByOrderId(widget.order.orderId);
    Map<String, dynamic> map = response.data;
    logistic_api.Logistic logistics = logistic_api.Logistic.fromJson(map);
    return logistics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).dingdanxiangqing,
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Text(S.of(context).dingdanxinxi,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(S.of(context).dingdanhao + '${widget.order.orderId}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    //客户名称
                    Text(S.of(context).kehu + '${widget.order.customerName}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Text(
                        S.of(context).xiaoshouyuan +
                            '${widget.order.salesmanName}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Text(S.of(context).chuangjianshijian + '${widget.order.createData}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    //是否确认
                    if (widget.order.confirm == 0)
                      Text(S.of(context).shifouqueren + S.of(context).weiqueren,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    if (widget.order.confirm == 1)
                      Text(S.of(context).shifouqueren + S.of(context).yiqueren,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text(S.of(context).shangpin + '${widget.order.goods}',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    Text(S.of(context).zongjia + '${widget.order.totalPrices}',
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 16),
                    //订单进度
                    if (widget.order.paymentSchedule == 0)
                      Text(S.of(context).dingdanjindu + S.of(context).weifukuan,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    if (widget.order.paymentSchedule == 1)
                      Text(S.of(context).dingdanjindu + S.of(context).yifukuan,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    if (widget.order.paymentSchedule == 2)
                      Text(
                          S.of(context).dingdanjindu + S.of(context).yiwancheng,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _confirmOrder,
                      child: Text(S.of(context).querendingdan),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              S.of(context).wuliuxinxi,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            FutureBuilder<logistic_api.Logistic>(
              future: futureLogistics,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  logistic_api.Logistic logistics = snapshot.data!;
                  return ListView(
                    shrinkWrap: true,
                    // this will make the ListView size to its children's height
                    physics: NeverScrollableScrollPhysics(),
                    // to disable the scrolling in ListView
                    children: logistics.rows.map<Widget>((row) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(S.of(context).fahuodi + row.dispatch,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Text(S.of(context).genzong + row.track,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              Text(
                                  S.of(context).wupinneirong + row.contentGoods,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 8),
                              if (row.progressState == 0)
                                Text(
                                    S.of(context).dangqianjindu +
                                        S.of(context).zhengzaichuku,
                                    style: const TextStyle(fontSize: 16)),
                              if (row.progressState == 1)
                                Text(
                                    S.of(context).dangqianjindu +
                                        S.of(context).dengdailanshou,
                                    style: const TextStyle(fontSize: 16)),
                              if (row.progressState == 2)
                                Text(
                                    S.of(context).dangqianjindu +
                                        S.of(context).zhengzaiyunshu,
                                    style: const TextStyle(fontSize: 16)),
                              if (row.progressState == 3)
                                Text(
                                    S.of(context).dangqianjindu +
                                        S.of(context).yididamudidi,
                                    style: const TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
