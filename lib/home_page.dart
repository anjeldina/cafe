import 'package:flutter/material.dart';
import 'menu_page.dart'; // Pastikan file menu_page.dart sudah dibuat

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const Color colorBrown = Color(0xFF3C2218);
  static const Color colorPink = Color(0xFFFFC7C7);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan berdasarkan BottomNavigationBar
  final List<Widget> _pages = [
    const HomeContent(),
    const MenuPage(),      // Mengambil dari file menu_page.dart
    const CheckoutPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: HomePage.colorBrown,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        elevation: 8,
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

// ================= CONTENT BERANDA =================
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  static const Color colorBrown = Color(0xFF3C2218);
  static const Color colorPink = Color(0xFFFFC7C7);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(),
            _buildHeroBanner(),
            _buildMenuGrid(),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
              child: Text(
                "Spesial Hari Ini",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorBrown,
                ),
              ),
            ),
            _buildHorizontalMenu(), // Bagian dengan gambar berbeda
          ],
        ),
      ),
    );
  }

  // Bar Atas (Poin & Lokasi)
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.stars, color: Colors.amber, size: 20),
              SizedBox(width: 5),
              Text("Silver 82%", style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(width: 12),
              Icon(Icons.monetization_on, color: Colors.amber, size: 20),
              SizedBox(width: 5),
              Text("32.000 pts", style: TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
              ],
            ),
            child: const Row(
              children: [
                Icon(Icons.location_on, color: colorBrown),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Menara Standard Chartered",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w600),
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

  // Banner Promo
  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 170,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: const DecorationImage(
          image: NetworkImage(
              'https://img.freepik.com/free-photo/delicious-coffee-beverage-with-splashes_23-2148419163.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.4), Colors.transparent],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        child: const Text(
          "Promo Coklat Hari Ini 🍫",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  // Grid Menu Icon
  Widget _buildMenuGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
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
          decoration: const BoxDecoration(shape: BoxShape.circle, color: colorPink),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 28,
            child: Icon(icon, color: colorBrown),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // List Horizontal Spesial Hari Ini
  Widget _buildHorizontalMenu() {
    // List data dengan gambar yang sudah Anda upload (cc.jpg, cm.jpg, cob.jpg)
    final List<Map<String, String>> spesialMenu = [
      {
        "nama": "Classic Choco",
        "harga": "Rp19.000",
        "gambar": "assets/images/cc.jpg"
      },
      {
        "nama": "Choco Mood",
        "harga": "Rp19.000",
        "gambar": "assets/images/cm.jpg"
      },
      {
        "nama": "Choco Oreo Blast",
        "harga": "Rp17.000",
        "gambar": "assets/images/cob.jpg"
      },
    ];

    return SizedBox(
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: spesialMenu.length,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(left: 16, right: 5, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: AssetImage(spesialMenu[index]["gambar"]!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        spesialMenu[index]["nama"]!,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        spesialMenu[index]["harga"]!,
                        style: const TextStyle(color: colorBrown, fontWeight: FontWeight.bold),
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

// ================= HALAMAN LAIN (STATIS) =================

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Halaman Checkout 🛒", style: TextStyle(fontSize: 20)));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("Halaman Profil 👤", style: TextStyle(fontSize: 20)));
}