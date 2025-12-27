import 'package:flutter/material.dart';
import '../categories/Gifts.dart';
import '../categories/Headphone.dart';
import '../categories/Mobile.dart';
import '../categories/Watch.dart';
import '../categories/laptop.dart';
import '../homepage.dart';
import '../cart.dart';
import '../profile.dart';
import '../theme_controller.dart';
import 'package:provider/provider.dart';

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
    final themeController = Provider.of<ThemeController>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
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
          SwitchListTile(
            secondary: Icon(Icons.brightness_6, color: Theme.of(context).colorScheme.primary),
            title: const Text('Dark Mode'),
            value: themeController.themeMode == ThemeMode.dark,
            onChanged: (val) => themeController.toggleDark(val),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.headphones, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.laptop, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.phone_android, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.watch, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.card_giftcard, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.shopping_cart, color: Theme.of(context).colorScheme.primary),
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
            leading: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
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
