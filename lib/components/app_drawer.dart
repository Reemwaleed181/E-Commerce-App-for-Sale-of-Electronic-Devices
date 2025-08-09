import 'package:flutter/material.dart';
import '../categories/Gifts.dart';
import '../categories/Headphone.dart';
import '../categories/Mobile.dart';
import '../categories/Watch.dart';
import '../categories/laptop.dart';
import '../homepage.dart';
import '../cart.dart';
import '../profile.dart';

class AppDrawer extends StatelessWidget {
  final String userName;
  final String userEmail;
  final Function(String, String)? onProfileUpdate;

  const AppDrawer({
    super.key,
    this.userName = "REEM",
    this.userEmail = "REEM1819@gmail.com",
    this.onProfileUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFFF6B00)),
            accountName: Text(
              userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(userEmail, style: const TextStyle(fontSize: 14)),
            currentAccountPicture: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'images2/women.jpg',
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xFFFF6B00)),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.headphones, color: Color(0xFFFF6B00)),
            title: const Text('Headphones'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buildHeadphonePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.laptop, color: Color(0xFFFF6B00)),
            title: const Text('Laptops'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buildLaptopPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android, color: Color(0xFFFF6B00)),
            title: const Text('Mobiles'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buildMobilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.watch, color: Color(0xFFFF6B00)),
            title: const Text('Watches'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buildWatchPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard, color: Color(0xFFFF6B00)),
            title: const Text('Gifts'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => buildGiftsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Color(0xFFFF6B00)),
            title: const Text('Cart'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Color(0xFFFF6B00)),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ProfilePage(userName: userName, userEmail: userEmail),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
