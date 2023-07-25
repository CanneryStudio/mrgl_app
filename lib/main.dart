import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ruoyi_app/routes/app_pages.dart';

import 'Application.dart';
import 'api/login.dart';
import 'api/system/user.dart';
import 'generated/l10n.dart';

void main() {
  // ignore: invalid_use_of_visible_for_testing_member
  Application.init().then((value) => runApp(const MyApp()));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetStorage().write(
        "initialRoute",
        GetStorage().hasData("token")
            ? AppPages.INITIAL
            : AppPages.INITIALLOGIN);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,

      ///国际化 自定义配置 目前配置了 英语和中文
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,

      initialRoute: GetStorage().read("initialRoute"),
      getPages: AppPages.routes,
      routingCallback: (routing) {
        if (routing?.current != "/login" &&
            routing?.current != "/login/webView") {
          getInfo();
          getUserProfile();
        }
        if (routing?.current == "/home") {
          getRouters();
        }
      },
    );
  }
}
