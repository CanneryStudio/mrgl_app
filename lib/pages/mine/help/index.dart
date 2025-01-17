import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          S.current.changjianwenti,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent, // 背景颜色设置为透明
        shadowColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          const ListTile(
            minLeadingWidth: -10,
            leading: Icon(
              Icons.contact_support,
              size: 30,
              color: Colors.black,
            ),
            title: Text(
              "",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 173,
              margin: const EdgeInsets.only(right: 15, left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      width: 1, color: const Color.fromRGBO(241, 241, 241, 1)),
                  borderRadius: const BorderRadius.all(Radius.circular(5.0))),
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(241, 241, 241, 1)))),
                    child: ListTile(
                      onTap: () {
                        var arg = {
                          "title": "如何退出登录？",
                          "context": "请点击[我的] - [应用设置] - [退出登录]即可退出登录"
                        };
                        Get.toNamed("/home/help/helpDetails", arguments: arg);
                      },
                      title: const Text(
                        "如何退出登录？",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(241, 241, 241, 1)))),
                    child: ListTile(
                      onTap: () {
                        var arg = {
                          "title": "如何修改用户头像？",
                          "context": "请点击[我的] - [选择头像] - [点击提交]即可更换用户头像"
                        };
                        Get.toNamed("/home/help/helpDetails", arguments: arg);
                      },
                      title: const Text(
                        "如何修改用户头像？",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(241, 241, 241, 1)))),
                    child: ListTile(
                      onTap: () {
                        var arg = {
                          "title": "如何修改登录密码？",
                          "context": "请点击[我的] - [应用设置] - [修改密码]即可修改登录密码"
                        };
                        Get.toNamed("/home/help/helpDetails", arguments: arg);
                      },
                      title: const Text(
                        "如何修改登录密码？",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
