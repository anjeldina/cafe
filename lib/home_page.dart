import 'package:flutter/material.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const Color colorBrown = Color(0xFF2E1B14); // lebih deep (elegan)
  static const Color colorPink = Color(0xFFFFF4F6);  // pink soft premium

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const MenuPage(),
    const CheckoutPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomePage.colorPink,
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: HomePage.colorBrown,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 6,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Checkout'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// ================= CONTENT =================
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  static const Color colorBrown = Color(0xFF2E1B14);

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
            _buildMenuGrid(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Text(
                "Spesial Hari Ini",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: colorBrown,
                ),
              ),
            ),
            _buildHorizontalMenu(),
          ],
        ),
      ),
    );
  }

  // ================= TOP BAR =================
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.stars, color: Colors.amber, size: 18),
              SizedBox(width: 6),
              Text("Silver 82%", style: TextStyle(fontSize: 13)),
              SizedBox(width: 12),
              Icon(Icons.monetization_on, color: Colors.amber, size: 18),
              SizedBox(width: 6),
              Text("32.000 pts", style: TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.pink.withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, color: colorBrown, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Menara Standard Chartered",
                    style: TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= HERO =================
  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 165,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        image: const DecorationImage(
          image: NetworkImage(
            'https://img.freepik.com/free-photo/delicious-coffee-beverage-with-splashes_23-2148419163.jpg',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black.withOpacity(0.25),
        ),
        padding: const EdgeInsets.all(18),
        alignment: Alignment.bottomLeft,
        child: const Text(
          "Promo Coklat Hari Ini 🍫",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  // ================= MENU ICON =================
  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _iconMenu(Icons.coffee, "Order"),
          _iconMenu(Icons.delivery_dining, "Delivery"),
          _iconMenu(Icons.restaurant, "Food"),
          _iconMenu(Icons.store, "Big Order"),
        ],
      ),
    );
  }

  Widget _iconMenu(IconData icon, String label) {
    return Column(
      children: [
        Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.pink.withOpacity(0.15)),
          ),
          child: Icon(icon, color: colorBrown),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  // ================= CARD MENU =================
  Widget _buildHorizontalMenu() {
    final List<Map<String, String>> spesialMenu = [
      {"nama": "Classic Choco", "harga": "Rp19.000", "gambar": "assets/images/cc.jpg"},
      {"nama": "Choco Mood", "harga": "Rp19.000", "gambar": "assets/images/cm.jpg"},
      {"nama": "Choco Oreo Blast", "harga": "Rp17.000", "gambar": "assets/images/cob.jpg"},
    ];

    return SizedBox(
      height: 215,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: spesialMenu.length,
        itemBuilder: (context, index) {
          return Container(
            width: 155,
            margin: const EdgeInsets.only(left: 16, bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.pink.withOpacity(0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
                  child: Image.asset(
                    spesialMenu[index]["gambar"]!,
                    height: 115,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spesialMenu[index]["nama"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: colorBrown,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spesialMenu[index]["harga"]!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: colorBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

// ================= PAGE LAIN =================
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Halaman Checkout 🛒"));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Halaman Profil 👤"));
}