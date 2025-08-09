import 'package:flutter/material.dart';
import '../items/laptop_items.dart';
import '../services/api_service.dart';
import 'base_category_page.dart';

Widget buildLaptopPage({
  String userName = "REEM",
  String userEmail = "REEM1819@gmail.com",
}) {
  return BaseCategoryPage(
    title: 'Laptop',
    searchHint: 'Search laptops...',
    items: ApiService().getLaptops(),
    itemDetailBuilder: (item) => LaptopItems(data2: item),
    userName: userName,
    userEmail: userEmail,
  );
}
