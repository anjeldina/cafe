import 'dart:ui';
import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'checkout_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  static const Color colorBrown = Color(0xFF2E1B14);
  static const Color colorPink = Color(0xFFFDF8F2); 
  static const Color colorGold = Color(0xFFC6A664);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, String>> cart = [];

  void _resetKeranjang() {
    setState(() {
      cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeContent(username: widget.username),
      MenuPage(
        onAddToCart: (item) {
          setState(() {
            cart.add(Map<String, String>.from(item));
          });
        },
        onResetCart: _resetKeranjang, 
      ),
      CheckoutPage(
        items: cart,
        onCheckoutSuccess: _resetKeranjang, 
      ),
      ProfilePage(username: widget.username),
    ];

    return Scaffold(
      backgroundColor: HomePage.colorPink,
      extendBody: true,
      body: pages[_selectedIndex],
      bottomNavigationBar: _buildCustomNavbar(),
    );
  }

  Widget _buildCustomNavbar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5),width: 1.5,),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.grid_view_rounded, 0),
              _buildNavItem(Icons.coffee_rounded, 1),
              _buildNavItem(Icons.shopping_bag_outlined, 2, badgeCount: cart.length),
              _buildNavItem(Icons.person_2_outlined, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, {int badgeCount = 0}) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 26,
                  color: isSelected ? HomePage.colorBrown : Colors.grey.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 5,
                  width: isSelected ? 5 : 0,
                  decoration: const BoxDecoration(
                    color: HomePage.colorBrown,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            if (badgeCount > 0 && index == 2)
              Positioned(
                right: 8,
                top: 12,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text('$badgeCount', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final String username;
  const HomeContent({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            _buildHeroBanner(),
            _buildSectionTitle("Layanan Kami"),
            _buildMenuGrid(),
            _buildSectionTitle("Spesial Hari Ini"),
            _buildHorizontalMenu(),
            // --- TAMBAHAN BAGIAN CAKE ---
            _buildSectionTitle("Pilihan Cake"),
            _buildCakeMenu(),
            // ----------------------------
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Good Morning,", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
              Text(username, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: HomePage.colorBrown)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05),blurRadius: 10,)],
            ),
            child: const Icon(Icons.notifications_none_rounded, color: HomePage.colorBrown),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 160,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              'assets/images/banner.png', 
              fit: BoxFit.cover, 
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Limited Offer", style: TextStyle(color: HomePage.colorGold, fontWeight: FontWeight.bold, fontSize: 12)),
                const Text("Good Mood Starts Here", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: HomePage.colorGold, borderRadius: BorderRadius.circular(10)),
                  child: const Text("Pesan Sekarang", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconMenu(Icons.local_cafe_rounded, "Order"),
          _iconMenu(Icons.delivery_dining_rounded, "Delivery"),
          _iconMenu(Icons.fastfood_rounded, "Food"),
          _iconMenu(Icons.storefront_rounded, "Pick Up"),
        ],
      ),
    );
  }

  Widget _iconMenu(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 60, width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: HomePage.colorBrown.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: Icon(icon, color: HomePage.colorBrown, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black54)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: HomePage.colorBrown)),
          const Text("Semua", style: TextStyle(color: HomePage.colorGold, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildHorizontalMenu() {
    final List<Map<String, String>> spesialMenu = [
      {"nama": "Classic Choco", "harga": "19.000", "gambar": "assets/images/cc.jpg"},
      {"nama": "Choco Mood", "harga": "19.000", "gambar": "assets/images/cm.jpg"},
      {"nama": "Choco Oreo Blast", "harga": "17.000", "gambar": "assets/images/cob.jpg"},
      {"nama": "Cloud Caramel Coffee", "harga": "22.000", "gambar": "assets/images/m1.jpg"},
      {"nama": "Caramel Cream Latte", "harga": "27.000", "gambar": "assets/images/m2.jpg"},
      {"nama": "Classic Iced Latte", "harga": "26.000", "gambar": "assets/images/m3.jpg"},
      {"nama": "Caramel Crunch Latte", "harga": "27.000", "gambar": "assets/images/m4.jpg"},
    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        physics: const BouncingScrollPhysics(),
        itemCount: spesialMenu.length,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 15, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: HomePage.colorBrown.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                    child: Image.asset(spesialMenu[index]["gambar"]!, fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(spesialMenu[index]["nama"]!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text("Rp ${spesialMenu[index]["harga"]!}", style: const TextStyle(color: HomePage.colorGold, fontSize: 13, fontWeight: FontWeight.w900)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCakeMenu() {
    final List<Map<String, String>> cakeMenu = [
      {"nama": "Berry Velvet Pudding", "harga": "25.000", "gambar": "assets/images/c1.jpg"},
      {"nama": "Blueberry Cloud Croissant", "harga": "27.000", "gambar": "assets/images/c2.jpg"},
      {"nama": "Caramel Bliss Cheesecake", "harga": "28.000", "gambar": "assets/images/c3.jpg"},
      {"nama": "Classic Velvet Tiramisu", "harga": "30.000", "gambar": "assets/images/c4.jpg"},
      {"nama": "Golden Caramel Flan", "harga": "26.000", "gambar": "assets/images/c5.jpg"},
      {"nama": "Chocolate Strawberry Slice", "harga": "30.000", "gambar": "assets/images/c6.jpg"},
      {"nama": "Chocolate Lava Cake", "harga": "32.000", "gambar": "assets/images/c7.jpg"},
      {"nama": "Chocolate Mud Cake Slice", "harga": "27.000", "gambar": "assets/images/c8.jpg"},
      {"nama": "Banana Chocolate Waffle", "harga": "30.000", "gambar": "assets/images/c9.jpg"},

    ];

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        physics: const BouncingScrollPhysics(),
        itemCount: cakeMenu.length,
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 15, bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [BoxShadow(color: HomePage.colorBrown.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                    child: Image.asset(cakeMenu[index]["gambar"]!, fit: BoxFit.cover, width: double.infinity),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cakeMenu[index]["nama"]!, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                      const SizedBox(height: 2),
                      Text("Rp ${cakeMenu[index]["harga"]!}", style: const TextStyle(color: HomePage.colorGold, fontSize: 13, fontWeight: FontWeight.w900)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}