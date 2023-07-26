import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';

import '../../api/system/user.dart';
import '../../generated/l10n.dart';

class MineIndex extends StatefulWidget {
  const MineIndex({Key? key}) : super(key: key);

  @override
  State<MineIndex> createState() => _MineIndexState();
}

class _MineIndexState extends State<MineIndex> {
  @override
  Widget build(BuildContext context) {
    var roleGroup = GetStorage().read("roleGroup") ?? "";
    if (roleGroup == "超级管理员") {
      roleGroup = S.current.chaojiguanliyuan;
    } else if (roleGroup == "会计") {
      roleGroup = S.current.kuaiji;
    } else if (roleGroup == "客户") {
      roleGroup = S.current.kehu;
    } else if (roleGroup == "销售") {
      roleGroup = S.current.xiaoshou;
    } else if (roleGroup == "经理") {
      roleGroup = S.current.jingli;
    } else if (roleGroup == "普通角色") {
      roleGroup = S.current.putongjuese;
    }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              S.current.wode,
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent, // 背景颜色设置为透明
            shadowColor: Colors.transparent,
          ),
          body: Container(
            child: ListView(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: const FractionalOffset(0.5, 0),
                      child: Container(
                        margin: EdgeInsets.only(),
                        height: 150,
                        color: Theme.of(context).colorScheme.secondary,
                        padding: const EdgeInsets.only(top: 40),
                        child: ListTile(
                          onTap: () async {
                            //跳转信息详情页
                            var data = await getUserProfile().then((value) {
                              if (value.data["code"] == 200) {
                                Get.toNamed("/home/info",
                                    arguments: {"args": value.data});
                              }
                            }, onError: (e) {
                              print(e);
                            });
                          },
                          leading: ClipOval(
                            child: Image.asset(
                              "static/images/profile.jpg",
                              width: 58,
                              height: 58,
                            ),
                          ),
                          title: Text(
                            "${S.current.yonghuming}${GetStorage().read("userName") ?? ""}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          subtitle: Text(
                            roleGroup,
                            style: const TextStyle(color: Colors.white),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const FractionalOffset(0.78, 0.29),
                      child: Container(
                        height: 280,
                        margin: const EdgeInsets.fromLTRB(15, 250, 15, 0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  ///TODO 跳转编辑资料页
                                  getProfile().then((value) => Get.toNamed(
                                      "/home/userEdit",
                                      arguments: {"arg": value.data}));
                                },
                                leading: Icon(
                                  Icons.perm_identity,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  S.current.bianjiziliao,
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              // ListTile(
                              //   onTap: () async {
                              //     ///TODO 跳转常见问题页
                              //     await Get.toNamed("/home/help");
                              //   },
                              //   leading: Icon(
                              //     Icons.help_outline,
                              //     color: Colors.blue,
                              //   ),
                              //   title: Text(
                              //     "常见问题",
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              //   trailing: Icon(Icons.keyboard_arrow_right),
                              // ),
                              // Divider(
                              //   thickness: 1,
                              // ),
                              // ListTile(
                              //   onTap: () async {
                              //     ///TODO 跳转关于我们页
                              //     await Get.toNamed("/home/about");
                              //   },
                              //   leading: Icon(
                              //     Icons.favorite_border,
                              //     color: Colors.blue,
                              //   ),
                              //   title: Text(
                              //     "关于我们",
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              //   trailing: Icon(Icons.keyboard_arrow_right),
                              // ),
                              // Divider(
                              //   thickness: 1,
                              // ),
                              ListTile(
                                onTap: () async {
                                  ///TODO 跳转应用设置页
                                  await Get.toNamed("/home/settings");
                                },
                                leading: Icon(
                                  Icons.settings,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  S.current.yingyongshezhi,
                                  style: TextStyle(fontSize: 16),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
