import 'package:flutter/material.dart';
import 'package:task1/profile.dart';
import 'cart.dart';
import 'categories/Gifts.dart';
import 'categories/Headphone.dart';
import 'categories/Mobile.dart';
import 'categories/Watch.dart';
import 'categories/laptop.dart';
import 'items/gifts_items.dart';
import 'items/headphone_items.dart';
import 'items/laptop_items.dart';
import 'items/mobile_items.dart';
import 'items/watch_items.dart';
import 'services/api_service.dart';
import 'components/app_drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  final ApiService _apiService = ApiService();
  late List<Map<String, dynamic>> items;
  List<Map<String, dynamic>> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();
  String userName = "REEM";
  String userEmail = "REEM1819@gmail.com";

  @override
  void initState() {
    super.initState();
    items = _apiService.getFeaturedProducts();
    filteredItems = items;
    _searchController.addListener(filterItems);
  }

  void filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems =
          items.where((item) {
            final title = item['title'].toLowerCase();
            final subtitle = item['subtitle'].toLowerCase();
            final subtitle2 = item['subtitle2'].toLowerCase();
            return title.contains(query) ||
                subtitle.contains(query) ||
                subtitle2.contains(query);
          }).toList();
    });
  }

  void updateUserInfo(String name, String email) {
    setState(() {
      userName = name;
      userEmail = email;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Homepage()),
          (Route<dynamic> route) => false,
        );
        break;
      case 1:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const CartPage()),
          (Route<dynamic> route) => false,
        );
        break;
      case 2:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder:
                (context) =>
                    ProfilePage(userName: userName, userEmail: userEmail),
          ),
          (Route<dynamic> route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppDrawer(
        userName: userName,
        userEmail: userEmail,
        onProfileUpdate: updateUserInfo,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two_outlined, color: Color(0xFFFF6B00)),
            Text(" Quick ", style: TextStyle(color: Colors.black)),
            Text("Shop", style: TextStyle(color: Color(0xFFFF6B00))),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SearchBarWidget(controller: _searchController),
            const SizedBox(height: 30),
            const SectionTitle(title: "Categories"),
            const SizedBox(height: 20),
            CategoriesSection(),
            const SizedBox(height: 30),
            const SectionTitle(title: "Featured Products"),
            const SizedBox(height: 20),
            FeaturedProductsGrid(items: filteredItems),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 25,
        selectedItemColor: const Color(0xFFFF6B00),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 8,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Color(0xFFFF6B00)),
          hintText: "Search products...",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
        ),
      ),
    );
  }
}

class CategoriesSection extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"iconname": Icons.laptop, "title": "Laptop"},
    {"iconname": Icons.phone_android_outlined, "title": "Mobile"},
    {"iconname": Icons.headphones, "title": "HeadPhones"},
    {"iconname": Icons.watch, "title": "Watch"},
    {"iconname": Icons.card_giftcard_outlined, "title": "Gifts"},
  ];

  CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return CategoryItem(
            icon: categories[i]["iconname"],
            title: categories[i]["title"],
            onTap: () => _navigateToCategory(context, categories[i]["title"]),
          );
        },
      ),
    );
  }

  void _navigateToCategory(BuildContext context, String category) {
    switch (category) {
      case "Laptop":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildLaptopPage()),
        );
        break;
      case "Mobile":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildMobilePage()),
        );
        break;
      case "HeadPhones":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildHeadphonePage()),
        );
        break;
      case "Watch":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildWatchPage()),
        );
        break;
      case "Gifts":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => buildGiftsPage()),
        );
        break;
    }
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 15),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFFF6B00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: const Color(0xFFFF6B00), size: 30),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class FeaturedProductsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  const FeaturedProductsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => ProductCard(item: items[index]),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const ProductCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToProductDetail(context),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    image: AssetImage(item['image']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['subtitle2'],
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item['price'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFF6B00),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetail(BuildContext context) {
    final title = item['title'].toLowerCase();
    if (title.contains('lenovo') ||
        title.contains('hp') ||
        title.contains('macbook') ||
        title.contains('asus')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LaptopItems(data2: item)),
      );
    } else if (title.contains('iphone') ||
        title.contains('samsung') ||
        title.contains('google')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MobileItems(data3: item)),
      );
    } else if (title.contains('airpods') ||
        title.contains('beats') ||
        title.contains('jbl')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HeadphoneItems(data4: item)),
      );
    } else if (title.contains('watch')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WatchItems(data5: item)),
      );
    } else if (title.contains('gift') ||
        title.contains('bundle') ||
        title.contains('kit')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GiftsItems(data6: item)),
      );
    }
  }
}
