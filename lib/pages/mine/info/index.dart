import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class InfoIndex extends StatefulWidget {
  const InfoIndex({Key? key}) : super(key: key);

  @override
  State<InfoIndex> createState() => _InfoIndexState();
}

class _InfoIndexState extends State<InfoIndex> {
  @override
  Widget build(BuildContext context) {
    final details = Get.arguments as Map;
    var data = details["args"]["roleGroup"] ?? "";
    if (data == "超级管理员") {
      data = S.current.chaojiguanliyuan;
    } else if (data == "会计") {
      data = S.current.kuaiji;
    } else if (data == "客户") {
      data = S.current.kehu;
    } else if (data == "销售") {
      data = S.current.xiaoshou;
    } else if (data == "经理") {
      data = S.current.jingli;
    } else if (data == "普通角色") {
      data = S.current.putongjuese;
    }
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          S.current.gerenxinxi,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent, // 背景颜色设置为透明
        shadowColor: Colors.transparent,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Color.fromARGB(500, 241, 241, 251)),
              )),
              child: ListTile(
                leading: const Icon(Icons.person),
                title:  Text(S.current.nicheng),
                trailing: Text(details["args"]["data"]["nickName"] ?? ""),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Color.fromARGB(500, 241, 241, 251)),
              )),
              child: ListTile(
                leading: const Icon(Icons.phone),
                title:  Text(S.current.shoujihaoma),
                trailing: Text(details["args"]["data"]["phonenumber"] ?? ""),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Color.fromARGB(500, 241, 241, 251)),
              )),
              child: ListTile(
                leading: const Icon(Icons.email),
                title:  Text(S.current.youxiang),
                trailing: Text(details["args"]["data"]["email"] ?? ""),
              ),
            ),
            // Container(
            //   decoration: const BoxDecoration(
            //       border: Border(
            //     top: BorderSide(
            //         width: 1,
            //         style: BorderStyle.solid,
            //         color: Color.fromARGB(500, 241, 241, 251)),
            //   )),
            //   child: ListTile(
            //     leading: const Icon(Icons.tune),
            //     title:  Text(S.current.bumen),
            //     trailing:
            //         Text(details["args"]["data"]["dept"]?["deptName"] ?? ""),
            //   ),
            // ),
            // Container(
            //   decoration: const BoxDecoration(
            //       border: Border(
            //     top: BorderSide(
            //         width: 1,
            //         style: BorderStyle.solid,
            //         color: Color.fromARGB(500, 241, 241, 251)),
            //   )),
            //   child: ListTile(
            //     leading: const Icon(Icons.how_to_reg),
            //     title:  Text(S.current.gangwei),
            //     trailing: Text(details["args"]["postGroup"] ?? ""),
            //   ),
            // ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(
                    width: 1,
                    style: BorderStyle.solid,
                    color: Color.fromARGB(500, 241, 241, 251)),
              )),
              child: ListTile(
                leading: const Icon(Icons.people),
                title:  Text(S.current.juese),
                trailing: Text(data),
              ),
            ),
            // Container(
            //   decoration: const BoxDecoration(
            //       border: Border(
            //     top: BorderSide(
            //         width: 1,
            //         style: BorderStyle.solid,
            //         color: Color.fromARGB(500, 241, 241, 251)),
            //     bottom: BorderSide(
            //         width: 1,
            //         style: BorderStyle.solid,
            //         color: Color.fromARGB(500, 241, 241, 251)),
            //   )),
            //   child: ListTile(
            //     leading: const Icon(Icons.event_available),
            //     title:  Text("创建日期"),
            //     trailing: Text(details["args"]["data"]["createTime"] ?? ""),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
