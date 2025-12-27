import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../homepage.dart';
import '../cart.dart';
import '../profile.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final String userName;
  final String userEmail;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    this.userName = "REEM",
    this.userEmail = "REEM1819@gmail.com",
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == selectedIndex) return; // Don't navigate to same page

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => CartPage(userName: userName, userEmail: userEmail),
          ),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    ProfilePage(userName: userName, userEmail: userEmail),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final itemCount = cart.items.length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home,
            label: 'Home',
            index: 0,
            isSelected: selectedIndex == 0,
          ),
          _buildNavItem(
            context,
            icon: Icons.shopping_cart,
            label: 'Cart',
            index: 1,
            isSelected: selectedIndex == 1,
            badgeCount: itemCount,
          ),
          _buildNavItem(
            context,
            icon: Icons.person,
            label: 'Profile',
            index: 2,
            isSelected: selectedIndex == 2,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    int badgeCount = 0,
  }) {
    final color =
        isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[600];

    return GestureDetector(
      onTap: () => _onItemTapped(context, index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Transform.translate(
                  offset: isSelected ? const Offset(0, -8) : Offset.zero,
                  child: Icon(icon, color: color, size: 28),
                ),
                if (badgeCount > 0 && index == 1)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Center(
                        child: Text(
                          badgeCount > 99 ? '99+' : '$badgeCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (!isSelected) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
