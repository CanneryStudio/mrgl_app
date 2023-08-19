import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.aboutUs,
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent, // 背景颜色设置为透明
        shadowColor: Colors.transparent,
      ),
      body: Container(
        margin: const EdgeInsets.only(right: 15, left: 15, top: 15),
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              child: GridView.count(
                crossAxisCount: 1,
                //childAspectRatio: 10.0,
                padding: const EdgeInsets.all(10),
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        // Image.asset(
                        //   "static/logo200.png",
                        //   width: 100,
                        // ),
                         Text(
                          S.current.morigeleyidongduan,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 230,
                margin: const EdgeInsets.only(right: 15, left: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 1,
                        color: const Color.fromRGBO(241, 241, 241, 1)),
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
                        onTap: () {},
                        title:  Text(
                          S.current.fuwurexian,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        trailing: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Text(
                                "10086",
                                style: TextStyle(fontSize: 16),
                              )),
                              WidgetSpan(
                                  child: Icon(Icons.keyboard_arrow_right))
                            ],
                          ),
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
                        onTap: () {},
                        title: const Text(
                          "公司网站",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        trailing: RichText(
                          text: const TextSpan(
                            children: [
                              WidgetSpan(
                                  child: Text(
                                "http://morigele.com",
                                style: TextStyle(fontSize: 16),
                              )),
                              WidgetSpan(
                                  child: Icon(Icons.keyboard_arrow_right))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
