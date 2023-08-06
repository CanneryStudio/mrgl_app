import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import 'home/index.dart';
import 'mine/index.dart';

class PageIndex extends StatefulWidget {
  const PageIndex({Key? key}) : super(key: key);

  @override
  State<PageIndex> createState() => _PageIndexState();
}

class _PageIndexState extends State<PageIndex> {
  int _index_current = 0;

  final List _pageList = [
    const HomeIndex(),
    const MineIndex(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList[_index_current],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index_current,
        onTap: (int index) {
          setState(() {
            _index_current = index;
          });
        },
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: S.current.dingdan),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: S.current.wode),
        ],
      ),
    );
  }
}
