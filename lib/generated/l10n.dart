// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `莫日格勒`
  String get topLoginText {
    return Intl.message(
      '莫日格勒',
      name: 'topLoginText',
      desc: '',
      args: [],
    );
  }

  /// `年龄`
  String get age {
    return Intl.message(
      '年龄',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `用户名`
  String get username {
    return Intl.message(
      '用户名',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `密码`
  String get password {
    return Intl.message(
      '密码',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `验证码`
  String get verifyCode {
    return Intl.message(
      '验证码',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get login {
    return Intl.message(
      '登录',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `登录即代表同意`
  String get agreement {
    return Intl.message(
      '登录即代表同意',
      name: 'agreement',
      desc: '',
      args: [],
    );
  }

  /// `《莫日格勒用户协议》`
  String get agreementLink {
    return Intl.message(
      '《莫日格勒用户协议》',
      name: 'agreementLink',
      desc: '',
      args: [],
    );
  }

  /// `《用户隐私》`
  String get userPrivateLink {
    return Intl.message(
      '《用户隐私》',
      name: 'userPrivateLink',
      desc: '',
      args: [],
    );
  }

  /// `编辑资料`
  String get editProfile {
    return Intl.message(
      '编辑资料',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `常见问题`
  String get commonProblem {
    return Intl.message(
      '常见问题',
      name: 'commonProblem',
      desc: '',
      args: [],
    );
  }

  /// `关于我们`
  String get aboutUs {
    return Intl.message(
      '关于我们',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `应用设置`
  String get settings {
    return Intl.message(
      '应用设置',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `发货地:`
  String get fahuodi {
    return Intl.message(
      '发货地:',
      name: 'fahuodi',
      desc: '',
      args: [],
    );
  }

  /// `跟踪:`
  String get genzong {
    return Intl.message(
      '跟踪:',
      name: 'genzong',
      desc: '',
      args: [],
    );
  }

  /// `物品内容:`
  String get wupinneirong {
    return Intl.message(
      '物品内容:',
      name: 'wupinneirong',
      desc: '',
      args: [],
    );
  }

  /// `确认订单`
  String get querendingdan {
    return Intl.message(
      '确认订单',
      name: 'querendingdan',
      desc: '',
      args: [],
    );
  }

  /// `莫日格勒移动端`
  String get morigeleyidongduan {
    return Intl.message(
      '莫日格勒移动端',
      name: 'morigeleyidongduan',
      desc: '',
      args: [],
    );
  }

  /// `服务热线`
  String get fuwurexian {
    return Intl.message(
      '服务热线',
      name: 'fuwurexian',
      desc: '',
      args: [],
    );
  }

  /// `系统接口`
  String get xitongjiekou {
    return Intl.message(
      '系统接口',
      name: 'xitongjiekou',
      desc: '',
      args: [],
    );
  }

  /// `常见问题`
  String get changjianwenti {
    return Intl.message(
      '常见问题',
      name: 'changjianwenti',
      desc: '',
      args: [],
    );
  }

  /// `修改密码`
  String get xiugaimima {
    return Intl.message(
      '修改密码',
      name: 'xiugaimima',
      desc: '',
      args: [],
    );
  }

  /// `修改头像`
  String get xiugaitouxiang {
    return Intl.message(
      '修改头像',
      name: 'xiugaitouxiang',
      desc: '',
      args: [],
    );
  }

  /// `修改资料`
  String get xiugaiziliao {
    return Intl.message(
      '修改资料',
      name: 'xiugaiziliao',
      desc: '',
      args: [],
    );
  }

  /// `个人信息`
  String get gerenxinxi {
    return Intl.message(
      '个人信息',
      name: 'gerenxinxi',
      desc: '',
      args: [],
    );
  }

  /// `应用设置`
  String get yingyongshezhi {
    return Intl.message(
      '应用设置',
      name: 'yingyongshezhi',
      desc: '',
      args: [],
    );
  }

  /// `我的`
  String get wode {
    return Intl.message(
      '我的',
      name: 'wode',
      desc: '',
      args: [],
    );
  }

  /// `昵称`
  String get nicheng {
    return Intl.message(
      '昵称',
      name: 'nicheng',
      desc: '',
      args: [],
    );
  }

  /// `登录`
  String get denglu {
    return Intl.message(
      '登录',
      name: 'denglu',
      desc: '',
      args: [],
    );
  }

  /// `请输入用户名`
  String get qingshuruyonghuming {
    return Intl.message(
      '请输入用户名',
      name: 'qingshuruyonghuming',
      desc: '',
      args: [],
    );
  }

  /// `请输入密码`
  String get qingshurumima {
    return Intl.message(
      '请输入密码',
      name: 'qingshurumima',
      desc: '',
      args: [],
    );
  }

  /// `请输入验证码`
  String get qingshuruyanzhengma {
    return Intl.message(
      '请输入验证码',
      name: 'qingshuruyanzhengma',
      desc: '',
      args: [],
    );
  }

  /// `登录即代表同意`
  String get tongyijidaibiaodenglu {
    return Intl.message(
      '登录即代表同意',
      name: 'tongyijidaibiaodenglu',
      desc: '',
      args: [],
    );
  }

  /// `用户服务协议`
  String get yonghufuwuxieyi {
    return Intl.message(
      '用户服务协议',
      name: 'yonghufuwuxieyi',
      desc: '',
      args: [],
    );
  }

  /// `《用户协议》`
  String get yonghuxieyi {
    return Intl.message(
      '《用户协议》',
      name: 'yonghuxieyi',
      desc: '',
      args: [],
    );
  }

  /// `《用户隐私》`
  String get yonghuyinsi {
    return Intl.message(
      '《用户隐私》',
      name: 'yonghuyinsi',
      desc: '',
      args: [],
    );
  }

  /// `隐私政策`
  String get yinsizhengce {
    return Intl.message(
      '隐私政策',
      name: 'yinsizhengce',
      desc: '',
      args: [],
    );
  }

  /// `订单号:`
  String get dingdanhao {
    return Intl.message(
      '订单号:',
      name: 'dingdanhao',
      desc: '',
      args: [],
    );
  }

  /// `订单列表`
  String get dingdanliebiao {
    return Intl.message(
      '订单列表',
      name: 'dingdanliebiao',
      desc: '',
      args: [],
    );
  }

  /// `订单`
  String get dingdan {
    return Intl.message(
      '订单',
      name: 'dingdan',
      desc: '',
      args: [],
    );
  }

  /// `商品：`
  String get shangpin {
    return Intl.message(
      '商品：',
      name: 'shangpin',
      desc: '',
      args: [],
    );
  }

  /// `总价：`
  String get zongjia {
    return Intl.message(
      '总价：',
      name: 'zongjia',
      desc: '',
      args: [],
    );
  }

  /// `当前进度：`
  String get dangqianjindu {
    return Intl.message(
      '当前进度：',
      name: 'dangqianjindu',
      desc: '',
      args: [],
    );
  }

  /// `正在出库`
  String get zhengzaichuku {
    return Intl.message(
      '正在出库',
      name: 'zhengzaichuku',
      desc: '',
      args: [],
    );
  }

  /// `等待揽收`
  String get dengdailanshou {
    return Intl.message(
      '等待揽收',
      name: 'dengdailanshou',
      desc: '',
      args: [],
    );
  }

  /// `正在运输`
  String get zhengzaiyunshu {
    return Intl.message(
      '正在运输',
      name: 'zhengzaiyunshu',
      desc: '',
      args: [],
    );
  }

  /// `已抵达目的地`
  String get yididamudidi {
    return Intl.message(
      '已抵达目的地',
      name: 'yididamudidi',
      desc: '',
      args: [],
    );
  }

  /// `订单详情`
  String get dingdanxiangqing {
    return Intl.message(
      '订单详情',
      name: 'dingdanxiangqing',
      desc: '',
      args: [],
    );
  }

  /// `用户名:`
  String get yonghuming {
    return Intl.message(
      '用户名:',
      name: 'yonghuming',
      desc: '',
      args: [],
    );
  }

  /// `会计`
  String get kuaiji {
    return Intl.message(
      '会计',
      name: 'kuaiji',
      desc: '',
      args: [],
    );
  }

  /// `客户`
  String get kehu {
    return Intl.message(
      '客户',
      name: 'kehu',
      desc: '',
      args: [],
    );
  }

  /// `销售`
  String get xiaoshou {
    return Intl.message(
      '销售',
      name: 'xiaoshou',
      desc: '',
      args: [],
    );
  }

  /// `经理`
  String get jingli {
    return Intl.message(
      '经理',
      name: 'jingli',
      desc: '',
      args: [],
    );
  }

  /// `普通角色`
  String get putongjuese {
    return Intl.message(
      '普通角色',
      name: 'putongjuese',
      desc: '',
      args: [],
    );
  }

  /// `超级管理员`
  String get chaojiguanliyuan {
    return Intl.message(
      '超级管理员',
      name: 'chaojiguanliyuan',
      desc: '',
      args: [],
    );
  }

  /// `手机号码`
  String get shoujihaoma {
    return Intl.message(
      '手机号码',
      name: 'shoujihaoma',
      desc: '',
      args: [],
    );
  }

  /// `邮箱`
  String get youxiang {
    return Intl.message(
      '邮箱',
      name: 'youxiang',
      desc: '',
      args: [],
    );
  }

  /// `部门`
  String get bumen {
    return Intl.message(
      '部门',
      name: 'bumen',
      desc: '',
      args: [],
    );
  }

  /// `岗位`
  String get gangwei {
    return Intl.message(
      '岗位',
      name: 'gangwei',
      desc: '',
      args: [],
    );
  }

  /// `角色`
  String get juese {
    return Intl.message(
      '角色',
      name: 'juese',
      desc: '',
      args: [],
    );
  }

  /// `旧密码`
  String get jiumima {
    return Intl.message(
      '旧密码',
      name: 'jiumima',
      desc: '',
      args: [],
    );
  }

  /// `新密码`
  String get xinmima {
    return Intl.message(
      '新密码',
      name: 'xinmima',
      desc: '',
      args: [],
    );
  }

  /// `请输入新密码`
  String get qingshuruxinmima {
    return Intl.message(
      '请输入新密码',
      name: 'qingshuruxinmima',
      desc: '',
      args: [],
    );
  }

  /// `检查更新`
  String get jianchagengxin {
    return Intl.message(
      '检查更新',
      name: 'jianchagengxin',
      desc: '',
      args: [],
    );
  }

  /// `退出登录`
  String get tuichudenglu {
    return Intl.message(
      '退出登录',
      name: 'tuichudenglu',
      desc: '',
      args: [],
    );
  }

  /// `系统提示`
  String get xitongtishi {
    return Intl.message(
      '系统提示',
      name: 'xitongtishi',
      desc: '',
      args: [],
    );
  }

  /// `您确定要退出吗？`
  String get ninquedingyaotuichumang {
    return Intl.message(
      '您确定要退出吗？',
      name: 'ninquedingyaotuichumang',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get quxiao {
    return Intl.message(
      '取消',
      name: 'quxiao',
      desc: '',
      args: [],
    );
  }

  /// `确定`
  String get queding {
    return Intl.message(
      '确定',
      name: 'queding',
      desc: '',
      args: [],
    );
  }

  /// `用户昵称`
  String get yonghunicheng {
    return Intl.message(
      '用户昵称',
      name: 'yonghunicheng',
      desc: '',
      args: [],
    );
  }

  /// `请输入昵称`
  String get qingshurunicheng {
    return Intl.message(
      '请输入昵称',
      name: 'qingshurunicheng',
      desc: '',
      args: [],
    );
  }

  /// `请输入手机号`
  String get qingshurushoujihao {
    return Intl.message(
      '请输入手机号',
      name: 'qingshurushoujihao',
      desc: '',
      args: [],
    );
  }

  /// `请输入邮箱`
  String get qingshuruyouxiang {
    return Intl.message(
      '请输入邮箱',
      name: 'qingshuruyouxiang',
      desc: '',
      args: [],
    );
  }

  /// `性别`
  String get xingbie {
    return Intl.message(
      '性别',
      name: 'xingbie',
      desc: '',
      args: [],
    );
  }

  /// `提交`
  String get tijiao {
    return Intl.message(
      '提交',
      name: 'tijiao',
      desc: '',
      args: [],
    );
  }

  /// `订单进度：`
  String get dingdanjindu {
    return Intl.message(
      '订单进度：',
      name: 'dingdanjindu',
      desc: '',
      args: [],
    );
  }

  /// `未付款`
  String get weifukuan {
    return Intl.message(
      '未付款',
      name: 'weifukuan',
      desc: '',
      args: [],
    );
  }

  /// `已付款`
  String get yifukuan {
    return Intl.message(
      '已付款',
      name: 'yifukuan',
      desc: '',
      args: [],
    );
  }

  /// `已完成`
  String get yiwancheng {
    return Intl.message(
      '已完成',
      name: 'yiwancheng',
      desc: '',
      args: [],
    );
  }

  /// `物流信息`
  String get wuliuxinxi {
    return Intl.message(
      '物流信息',
      name: 'wuliuxinxi',
      desc: '',
      args: [],
    );
  }

  /// `订单信息`
  String get dingdanxinxi {
    return Intl.message(
      '订单信息',
      name: 'dingdanxinxi',
      desc: '',
      args: [],
    );
  }

  /// `销售员：`
  String get xiaoshouyuan {
    return Intl.message(
      '销售员：',
      name: 'xiaoshouyuan',
      desc: '',
      args: [],
    );
  }

  /// `是否确认：`
  String get shifouqueren {
    return Intl.message(
      '是否确认：',
      name: 'shifouqueren',
      desc: '',
      args: [],
    );
  }

  /// `未确认`
  String get weiqueren {
    return Intl.message(
      '未确认',
      name: 'weiqueren',
      desc: '',
      args: [],
    );
  }

  /// `已确认`
  String get yiqueren {
    return Intl.message(
      '已确认',
      name: 'yiqueren',
      desc: '',
      args: [],
    );
  }

  /// `创建时间:`
  String get chuangjianshijian {
    return Intl.message(
      '创建时间:',
      name: 'chuangjianshijian',
      desc: '',
      args: [],
    );
  }

  /// `编辑资料`
  String get bianjiziliao {
    return Intl.message(
      '编辑资料',
      name: 'bianjiziliao',
      desc: '',
      args: [],
    );
  }

  /// `请输入旧密码`
  String get qingshurujiumima {
    return Intl.message(
      '请输入旧密码',
      name: 'qingshurujiumima',
      desc: '',
      args: [],
    );
  }

  /// `销售下单`
  String get xiaoshouxiadan {
    return Intl.message(
      '销售下单',
      name: 'xiaoshouxiadan',
      desc: '',
      args: [],
    );
  }

  /// `数量:{good.amount}\n单价:{good.unitPrice}{widget.order.currencyType}\n总价:{good.totalPrice}{widget.order.currencyType}`
  String get shangpinxinxi {
    return Intl.message(
      '数量:{good.amount}\n单价:{good.unitPrice}{widget.order.currencyType}\n总价:{good.totalPrice}{widget.order.currencyType}',
      name: 'shangpinxinxi',
      desc: '',
      args: [],
    );
  }

  /// `商品名称: ${good.name!}`
  String get goodNameGoodname {
    return Intl.message(
      '商品名称: \${good.name!}',
      name: 'goodNameGoodname',
      desc: '',
      args: [],
    );
  }

  /// `物流状态`
  String get wuliuzhuangtai {
    return Intl.message(
      '物流状态',
      name: 'wuliuzhuangtai',
      desc: '',
      args: [],
    );
  }

  /// `状态描述`
  String get zhuangtaimiaoshu {
    return Intl.message(
      '状态描述',
      name: 'zhuangtaimiaoshu',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
