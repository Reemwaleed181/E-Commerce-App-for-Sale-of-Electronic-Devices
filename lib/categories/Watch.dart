import 'package:flutter/material.dart';
import '../items/watch_items.dart';
import '../services/api_service.dart';
import 'base_category_page.dart';

Widget buildWatchPage({
  String userName = "REEM",
  String userEmail = "REEM1819@gmail.com",
}) {
  return BaseCategoryPage(
    title: 'Watch',
    searchHint: 'Search watches...',
    items: ApiService().getWatches(),
    itemDetailBuilder: (item) => WatchItems(data5: item),
    userName: userName,
    userEmail: userEmail,
  );
}
