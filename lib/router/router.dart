import 'package:get/get.dart';
import 'package:pe_over_cloud/screens/allscreens.dart';

//路由配置文件

List<GetPage> namedPages = [
  GetPage(name: '/', page: () => getstartpage()),
  GetPage(name: '/clause', page: () => getclausepage()),
];
