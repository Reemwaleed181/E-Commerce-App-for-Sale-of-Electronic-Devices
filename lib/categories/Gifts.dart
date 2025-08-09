import 'package:flutter/material.dart';
import '../items/gifts_items.dart';
import '../services/api_service.dart';
import 'base_category_page.dart';

Widget buildGiftsPage({
  String userName = "REEM",
  String userEmail = "REEM1819@gmail.com",
}) {
  return BaseCategoryPage(
    title: 'Gifts',
    searchHint: 'Search gifts...',
    items: ApiService().getGifts(),
    itemDetailBuilder: (item) => GiftsItems(data6: item),
    userName: userName,
    userEmail: userEmail,
  );
}
