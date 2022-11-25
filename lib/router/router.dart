import 'package:get/get.dart';
import 'package:pe_over_cloud/screens/allscreens.dart';

//路由配置文件

List<GetPage> namedPages = [
  GetPage(name: '/', page: () => gethellopage()),
  GetPage(name: '/clause', page: () => getclausepage()),
  GetPage(name: '/login', page: () => getloginpage()),
  GetPage(name: '/register', page: () => getregisterpage()),
];
