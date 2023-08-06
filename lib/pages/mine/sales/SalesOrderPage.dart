import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/api/system/data/customerandsales/sales_entity.dart';
import 'package:ruoyi_app/api/system/data/order/order_entity.dart';
import 'package:ruoyi_app/api/system/data/sales.dart';

import '../../../api/system/data/order/currency_type.dart';
import '../../../api/system/data/order/good_entity.dart';
import '../../../api/system/order.dart';
import '../../../generated/l10n.dart';

class SalesOrderPage extends StatefulWidget {
  const SalesOrderPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SalesOrderPageState();
  }
}

class _SalesOrderPageState extends State<SalesOrderPage> {
  String _selectedUser = "";
  String _orderContent = "";
  String _selectedQuantity = "";
  String _selectedUnitPrice = "";
  CurrencyType _selectedCurrency = CurrencyType.CNY;

  late List<SalesRows> _customerAndSalesEntity = [];
  List<Map<String, dynamic>> goodsTableRows = [];

  //可选的用户
  final List<String> _users = [];

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _orderContentController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();

  Future<void> getCustomerAndSales() async {
    var response = await getSales();
    var sales = response.data;
    var salesEntity = SalesEntity.fromJson(sales);
    setState(() {
      _customerAndSalesEntity = salesEntity.rows!;
      salesEntity.rows?.forEach((element) {
        var customername = element.customerID;
        if (!_users.contains(customername)) {
          _users.add(customername!);
        }
      });
      if (_users.isNotEmpty) {
        _selectedUser = _users.first;
      }
    });
  }

  Future<void> submit(OrderEntity orderEntity) async {
    var response = await submitOrder(orderEntity);
    if (response.code == 200) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    getCustomerAndSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).xiaoshouxiadan,
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            _buildTable(),
            const SizedBox(height: 50),
            _buildDropdownButton(
                label: "请选择用户",
                value: _selectedUser,
                items: _users,
                onChanged: (value) {
                  setState(() {
                    _selectedUser = value!;
                  });
                }),
            const SizedBox(height: 10),
            //商品名称
            TextField(
              controller: _orderContentController,
              decoration: const InputDecoration(
                labelText: '请输入商品名称',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _orderContent = value;
                });
              },
            ),
            const SizedBox(height: 10),
            //单价
            TextField(
              controller: _unitPriceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '请输入单价',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedUnitPrice = value;
                });
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '请输入数量',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _selectedQuantity = value;
                });
              },
            ),
            SizedBox(height: 10),
            _buildDropdownButton(
              label: "请选择货币",
              value: currencyData[_selectedCurrency]!['name']!,
              items: CurrencyType.values
                  .map((e) => currencyData[e]!['name']!)
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCurrency = CurrencyType.values.firstWhere(
                    (e) => currencyData[e]!['name'] == value,
                  );
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  var good = GoodGoods();
                  good.name = _orderContent;
                  good.unitPrice = double.parse(_selectedUnitPrice);
                  good.amount = int.tryParse(_selectedQuantity);
                  good.totalPrice =
                      good.amount! * double.parse(_selectedUnitPrice);
                  setState(() {
                    goodsTableRows.add({
                      'name': _orderContent,
                      'amount': _selectedQuantity.toString(),
                      'unit_price': good.unitPrice.toString(),
                      'total_price': good.totalPrice.toString(),
                    });
                  });
                },
                child: Text("添加")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                try {
                  Map<String,dynamic> requestJson={
                    "customerName": _selectedUser,
                    "salesmanName": GetStorage().read('userName'),
                    "goods": json.encode(goodsTableRows),
                    "paymentSchedule": 0,
                    "totalPrices": goodsTableRows.map((e) => e['total_price']).reduce((value, element) => value + element),
                    "currencyType": _selectedCurrency.name,
                  };
                  Get.snackbar(
                    'Success',
                    'Your order has been submitted!',
                    snackPosition: SnackPosition.TOP,
                  );
                  submitOrder(json.encode(requestJson));
                } catch (e) {
                  if (kDebugMode) {
                    print(e);
                  }
                  Get.snackbar(
                    'Error',
                    'Please check the input',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text('提交'),
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
        border: OutlineInputBorder(),
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

  Widget _buildTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          // Center the text vertically
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: IntrinsicColumnWidth(),
            2: IntrinsicColumnWidth(),
            3: IntrinsicColumnWidth(),
            4: IntrinsicColumnWidth(), // New column for delete button
          },
          children: <TableRow>[
            const TableRow(
              children: <Widget>[
                Center(
                    child: Text('货物名称',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text('数量',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text('单价',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text('总价',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text('操作',
                        style: TextStyle(fontWeight: FontWeight.bold))),
                // Delete button header
              ],
            ),
            ...goodsTableRows.asMap().entries.map((entry) {
              final int index = entry.key;
              final Map<String, dynamic> item = entry.value;
              return TableRow(children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Text(item['name'])),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Text(item['amount'].toString())),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Text(item['unit_price'].toString())),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: Text(item['total_price'].toString())),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            goodsTableRows.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ]);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
