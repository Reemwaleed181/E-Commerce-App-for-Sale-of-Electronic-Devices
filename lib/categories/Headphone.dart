import 'package:flutter/material.dart';
import '../items/headphone_items.dart';
import '../services/api_service.dart';
import 'base_category_page.dart';

Widget buildHeadphonePage({
  String userName = "REEM",
  String userEmail = "REEM1819@gmail.com",
}) {
  return BaseCategoryPage(
    title: 'Headphone',
    searchHint: 'Search headphones...',
    items: ApiService().getHeadphones(),
    itemDetailBuilder: (item) => HeadphoneItems(data4: item),
    userName: userName,
    userEmail: userEmail,
  );
}
