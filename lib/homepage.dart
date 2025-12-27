import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile.dart';
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
import 'favorites_controller.dart';
import 'services/api_service.dart';
import 'components/app_drawer.dart';
import 'components/custom_bottom_nav.dart';
import 'components/creative_image_frame.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  final ApiService _apiService = ApiService();
  late List<Map<String, dynamic>> items;
  List<Map<String, dynamic>> filteredItems = [];
  final TextEditingController _searchController = TextEditingController();
  String userName = "REEM";
  String userEmail = "REEM1819@gmail.com";
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0;
  int _selectedChipIndex = 0; // 0 = All

  @override
  void initState() {
    super.initState();
    items = _apiService.getFeaturedProducts();
    filteredItems = items;
    _searchController.addListener(filterItems);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  Widget _buildBrandHeader() {
    return SizedBox(
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: 160,
          child: Image.asset(
            'images2/logo2.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'images2/logo2.png',
                height: 160,
                fit: BoxFit.contain,
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void filterItems() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredItems =
          items.where((item) {
            final title = (item['title'] ?? '').toLowerCase();
            final subtitle = (item['subtitle'] ?? '').toLowerCase();
            final subtitle2 = (item['subtitle2'] ?? '').toLowerCase();
            final matchesText =
                title.contains(query) ||
                subtitle.contains(query) ||
                subtitle2.contains(query);
            final matchesChip =
                _selectedChipIndex == 0
                    ? true
                    : _itemMatchesCategory(
                      item,
                      _chipOptions[_selectedChipIndex],
                    );
            return matchesText && matchesChip;
          }).toList();
    });
  }

  bool _itemMatchesCategory(Map<String, dynamic> item, String category) {
    final title = (item['title'] ?? '').toString().toLowerCase();
    switch (category) {
      case 'Laptop':
        return title.contains('lenovo') ||
            title.contains('hp') ||
            title.contains('macbook') ||
            title.contains('asus');
      case 'Mobile':
        return title.contains('iphone') ||
            title.contains('samsung') ||
            title.contains('google');
      case 'HeadPhones':
        return title.contains('airpods') ||
            title.contains('beats') ||
            title.contains('jbl');
      case 'Watch':
        return title.contains('watch');
      case 'Gifts':
        return title.contains('gift') ||
            title.contains('bundle') ||
            title.contains('kit');
      default:
        return true;
    }
  }

  void updateUserInfo(String name, String email) {
    setState(() {
      userName = name;
      userEmail = email;
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) => const CartPage(),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: child,
              );
            },
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder:
                (context, animation, secondaryAnimation) =>
                    ProfilePage(userName: userName, userEmail: userEmail),
            transitionsBuilder: (
              context,
              animation,
              secondaryAnimation,
              child,
            ) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                ),
                child: child,
              );
            },
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      endDrawer: AppDrawer(
        userName: userName,
        userEmail: userEmail,
        onProfileUpdate: updateUserInfo,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.15),
                      shape: const CircleBorder(),
                    ),
                  ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.15),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              ProfilePage(
                                userName: userName,
                                userEmail: userEmail,
                              ),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeInOut,
                            ),
                          ),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.15),
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBrandHeader(),
                  const SizedBox(height: 12),
                  _buildWelcomeSection(),
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 32),
                  _buildPromoBanner(),
                  const SizedBox(height: 16),
                  _buildCategoriesSection(),
                  const SizedBox(height: 16),
                  _buildCategoryChips(),
                  const SizedBox(height: 24),

                  const SizedBox(height: 8),
                  _buildFeaturedProductsSection(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: 0, // Homepage
        userName: userName,
        userEmail: userEmail,
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: GoogleFonts.inter(
              fontSize: 16,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            userName,
            style: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'What are you looking for today?',
            style: GoogleFonts.inter(
              fontSize: 16,
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: GoogleFonts.inter(
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[500]
                    : Colors.grey[500],
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.primary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Clearance Sales',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Up to 50% off',
                    style: GoogleFonts.inter(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.white.withOpacity(0.25),
              width: 90,
              height: 64,
              child: const Icon(Icons.local_offer, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  final List<String> _chipOptions = const [
    'All',
    'Laptop',
    'Mobile',
    'HeadPhones',
    'Watch',
    'Gifts',
  ];

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _chipOptions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == _selectedChipIndex;
          return ChoiceChip(
            label: Text(
              _chipOptions[index],
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color:
                    selected
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
              ),
            ),
            selected: selected,
            onSelected: (val) {
              setState(() {
                _selectedChipIndex = index;
              });
              filterItems();
            },
            selectedColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).cardColor,
            shape: StadiumBorder(
              side: BorderSide(
                color:
                    selected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[700]!
                        : Colors.grey[300]!,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _CategoryCard(
                  icon: category['icon'],
                  title: category['title'],
                  color: category['color'],
                  image: category['image'],
                  onTap: () => _navigateToCategory(context, category['title']),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProductsSection() {
    final favorites = context.watch<FavoritesController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Products',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final title = filteredItems[index]['title'] ?? '';
            return _ProductCard(
              item: filteredItems[index],
              onTap:
                  () => _navigateToProductDetail(context, filteredItems[index]),
              isFavorite: favorites.isFavorite(title),
              onFavoriteToggle: () => favorites.toggle(title),
            );
          },
        ),
      ],
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

  void _navigateToProductDetail(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    final title = (item['title'] ?? '').toLowerCase();
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

  final List<Map<String, dynamic>> _categories = [
    {
      "icon": Icons.laptop,
      "title": "Laptop",
      "color": Color(0xFFFF6B00),
      "image": "images2/Lenovo_IdeaPad.png",
    },
    {
      "icon": Icons.phone_android_outlined,
      "title": "Mobile",
      "color": Color(0xFFFF8A00),
      "image": "images2/phone2.png",
    },
    {
      "icon": Icons.headphones,
      "title": "HeadPhones",
      "color": Color(0xFFFFA733),
      "image": "images2/Apple_AirPods_Max__Noise_Cancelling.png",
    },
    {
      "icon": Icons.watch,
      "title": "Watch",
      "color": Color(0xFFFFC266),
      "image": "images2/watch.png",
    },
    {
      "icon": Icons.card_giftcard_outlined,
      "title": "Gifts",
      "color": Color(0xFFFF8A00),
      "image": "images2/gift1.png",
    },
  ];
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final String image;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color.withOpacity(0.25), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.12),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[800]?.withOpacity(0.3)
                          : Colors.white.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withOpacity(0.25),
                              color.withOpacity(0.15),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: color, size: 24),
                      );
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const _ProductCard({
    required this.item,
    required this.onTap,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CreativeImageFrame(
                      imageUrl: item['image'] ?? '',
                      width: double.infinity,
                      height: 120,
                      frameStyle: FrameStyle.modern,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 18,
                        padding: const EdgeInsets.all(6),
                        constraints: const BoxConstraints(),
                        onPressed: onFavoriteToggle,
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                        ),
                        color:
                            isFavorite
                                ? Colors.redAccent
                                : Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.grey[400]
                                : Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, size: 14, color: Colors.amber[600]),
                      const SizedBox(width: 2),
                      Text(
                        '4.8',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[400]
                                  : Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item['subtitle2'] ?? '',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['price'],
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add_shopping_cart,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
