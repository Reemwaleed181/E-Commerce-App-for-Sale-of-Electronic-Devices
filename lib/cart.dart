import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'payment_page.dart';
import 'homepage.dart';
import 'profile.dart';
import 'components/custom_bottom_nav.dart';
import 'components/creative_image_frame.dart';
import 'components/app_drawer.dart';

// Enhanced Cart with creative design
class Cart extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get subtotal {
    return _items.fold(0.0, (sum, item) {
      final price =
          double.tryParse(
            item["price"]?.toString().replaceAll('\$', '') ?? '0',
          ) ??
          0.0;
      final quantity = item["quantity"] ?? 1;
      return sum + (price * quantity);
    });
  }

  double get shipping {
    return subtotal > 0 ? 15.0 : 0.0;
  }

  double get tax {
    return subtotal * 0.08;
  }

  double get total {
    return subtotal + shipping + tax;
  }

  void addItem(Map<String, dynamic> item) {
    final existingItem = _items.firstWhere(
      (i) => i['title'] == item['title'],
      orElse: () => {},
    );

    if (existingItem.isNotEmpty) {
      existingItem['quantity']++;
    } else {
      _items.add({...item, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(Map<String, dynamic> item) {
    _items.removeWhere((i) => i['title'] == item['title']);
    notifyListeners();
  }

  void updateQuantity(Map<String, dynamic> item, int quantity) {
    final cartItem = _items.firstWhere(
      (i) => i['title'] == item['title'],
      orElse: () => {},
    );
    if (cartItem.isNotEmpty) {
      cartItem['quantity'] = quantity;
      if (cartItem['quantity'] <= 0) {
        _items.removeWhere((i) => i['title'] == item['title']);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}

// Creative Cart Page with modern design
class CartPage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const CartPage({
    super.key,
    this.userName = "REEM",
    this.userEmail = "REEM1819@gmail.com",
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final cartItems = cart.items;
    final subtotal = cart.subtotal;
    final shipping = cart.shipping;
    final tax = cart.tax;
    final total = cart.total;

    return Scaffold(
      extendBodyBehindAppBar: true,
      endDrawer: AppDrawer(
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: false,
            snap: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true, // Show back arrow if there's a route to go back
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.15),
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ],
            title: Text(
              'Shopping Cart',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  if (cartItems.isEmpty)
                    _buildEmptyCart()
                  else
                    _buildCartContent(
                      cart,
                      cartItems,
                      subtotal,
                      shipping,
                      tax,
                      total,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNav(
        selectedIndex: 1, // Cart page
        userName: widget.userName,
        userEmail: widget.userEmail,
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 120,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some amazing products to get started!',
            style: GoogleFonts.inter(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const Homepage()),
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.shopping_bag),
            label: Text(
              'Start Shopping',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(
    Cart cart,
    List<Map<String, dynamic>> cartItems,
    double subtotal,
    double shipping,
    double tax,
    double total,
  ) {
    return Column(
      children: [
        _buildCartItemsList(cartItems),
        const SizedBox(height: 24),
        _buildOrderSummary(subtotal, shipping, tax, total),
        const SizedBox(height: 12),
        SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showPaymentOptions(context, total),
              icon: const Icon(Icons.payment),
              label: Text(
                'Checkout \$${total.toStringAsFixed(2)}',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItemsList(List<Map<String, dynamic>> cartItems) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            final item = cartItems[index];
            return _CartItemCard(
              item: item,
              onQuantityChanged:
                  (quantity) => Provider.of<Cart>(
                    context,
                    listen: false,
                  ).updateQuantity(item, quantity),
              onRemove:
                  () => Provider.of<Cart>(
                    context,
                    listen: false,
                  ).removeItem(item),
            );
          },
        ),
      ],
    );
  }

  Widget _buildOrderSummary(
    double subtotal,
    double shipping,
    double tax,
    double total,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Summary',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Subtotal', subtotal),
          _buildSummaryRow('Shipping', shipping),
          _buildSummaryRow('Tax', tax),
          const Divider(height: 32),
          _buildSummaryRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? Colors.black : Colors.grey[700],
            ),
          ),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color:
                  isTotal
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentOptions(BuildContext context, double total) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(
          totalAmount: total,
          paymentMethod: 'card',
          userName: widget.userName,
          userEmail: widget.userEmail,
        ),
      ),
    );
  }

  void _processPayment(BuildContext context, String method, double total) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => PaymentPage(totalAmount: total, paymentMethod: method),
      ),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CreativeImageFrame(
              imageUrl: item['image'] ?? 'images2/placeholder.png',
              width: 80,
              height: 80,
              frameStyle: FrameStyle.elegant,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['subtitle2'] ?? '',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${item['price'] ?? '0'}',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => onQuantityChanged(item['quantity'] - 1),
                      color: Colors.grey[600],
                    ),
                    Text(
                      '${item['quantity']}',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => onQuantityChanged(item['quantity'] + 1),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: onRemove,
                  color: Colors.red[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _PaymentOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
