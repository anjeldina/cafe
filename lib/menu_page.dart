import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const Color colorBrown = Color(0xFF3C2218);
  static const Color colorPink = Color(0xFFFFC7C7);

  @override
  Widget build(BuildContext context) {
    // Data dummy untuk daftar menu
    final List<Map<String, String>> allMenus = [
      {"nama": "Classic Choco", "harga": "Rp19.000", "img": "assets/images/cc.jpg", "desc": "Coklat murni dengan susu segar"},
      {"nama": "Choco Mood", "harga": "Rp19.000", "img": "assets/images/cm.jpg", "desc": "Mood booster coklat spesial"},
      {"nama": "Choco Oreo Blast", "harga": "Rp17.000", "img": "assets/images/cob.jpg", "desc": "Perpaduan coklat dan oreo"},
      {"nama": "Caramel Latte", "harga": "Rp22.000", "img": "assets/images/cc.jpg", "desc": "Kopi susu dengan sirup karamel"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Menu Kami",
          style: TextStyle(color: colorBrown, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Kategori Horizontal
          _buildCategoryList(),
          
          // Daftar Menu Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: allMenus.length,
                itemBuilder: (context, index) {
                  return _buildMenuCard(allMenus[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    List<String> categories = ["Semua", "Coklat", "Kopi", "Makanan", "Promo"];
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: index == 0 ? 16 : 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: index == 0 ? colorBrown : colorPink.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              style: TextStyle(
                color: index == 0 ? Colors.white : colorBrown,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuCard(Map<String, String> menu) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage(menu["img"]!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  menu["nama"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  menu["desc"]!,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Text(
                  menu["harga"]!,
                  style: const TextStyle(color: colorBrown, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}