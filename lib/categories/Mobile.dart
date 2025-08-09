import 'package:flutter/material.dart';
import '../items/mobile_items.dart';
import '../services/api_service.dart';
import 'base_category_page.dart';

Widget buildMobilePage({
  String userName = "REEM",
  String userEmail = "REEM1819@gmail.com",
}) {
  return BaseCategoryPage(
    title: 'Mobile',
    searchHint: 'Search mobiles...',
    items: ApiService().getMobiles(),
    itemDetailBuilder: (item) => MobileItems(data3: item),
    userName: userName,
    userEmail: userEmail,
  );
}
