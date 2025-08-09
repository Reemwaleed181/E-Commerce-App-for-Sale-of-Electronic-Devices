import 'package:flutter/material.dart';
import '../components/app_drawer.dart';

class BaseCategoryPage extends StatefulWidget {
  final String title;
  final String searchHint;
  final List<Map<String, dynamic>> items;
  final Widget Function(Map<String, dynamic> item) itemDetailBuilder;
  final String userName;
  final String userEmail;

  const BaseCategoryPage({
    super.key,
    required this.title,
    required this.searchHint,
    required this.items,
    required this.itemDetailBuilder,
    this.userName = "REEM",
    this.userEmail = "REEM1819@gmail.com",
  });

  @override
  State<BaseCategoryPage> createState() => _BaseCategoryPageState();
}

class _BaseCategoryPageState extends State<BaseCategoryPage> {
  late List<Map<String, dynamic>> filteredItems;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems =
          widget.items.where((item) {
            final title = (item['title'] ?? '').toLowerCase();
            final subtitle = (item['subtitle'] ?? '').toLowerCase();
            final subtitle2 = (item['subtitle2'] ?? '').toLowerCase();
            return title.contains(query) ||
                subtitle.contains(query) ||
                subtitle2.contains(query);
          }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shop_two_outlined, color: Color(0xFFFF6B00)),
            const Text(" Quick ", style: TextStyle(color: Colors.black)),
            Text(
              widget.title,
              style: const TextStyle(color: Color(0xFFFF6B00)),
            ),
          ],
        ),
      ),
      endDrawer: AppDrawer(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color(0xFFFF6B00)),
                hintText: widget.searchHint,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            "Best Selling",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          GridView.builder(
            itemCount: filteredItems.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 320,
            ),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              widget.itemDetailBuilder(filteredItems[i]),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        height: 150,
                        color: Colors.grey[200],
                        child: Image.asset(
                          filteredItems[i]['image'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredItems[i]['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              filteredItems[i]['subtitle'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              filteredItems[i]['subtitle2'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              filteredItems[i]['price'] ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
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
            },
          ),
        ],
      ),
    );
  }
}
