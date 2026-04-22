import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const Color colorBrown = Color(0xFF2E1B14);
  static const Color colorPink = Color(0xFFFFF4F6);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> allMenus = [
      {
        "nama": "Classic Choco",
        "harga": "Rp19.000",
        "img": "assets/images/cc.jpg",
        "desc": "Coklat murni dengan susu segar"
      },
      {
        "nama": "Choco Mood",
        "harga": "Rp19.000",
        "img": "assets/images/cm.jpg",
        "desc": "Mood booster coklat spesial"
      },
      {
        "nama": "Choco Oreo Blast",
        "harga": "Rp17.000",
        "img": "assets/images/cob.jpg",
        "desc": "Perpaduan coklat dan oreo"
      },
      {
        "nama": "Caramel Latte",
        "harga": "Rp22.000",
        "img": "assets/images/cc.jpg",
        "desc": "Kopi susu dengan sirup karamel"
      },
    ];

    return Scaffold(
      backgroundColor: colorPink,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Menu Kami",
          style: TextStyle(
            color: colorBrown,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildCategoryList(),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: allMenus.length,
              itemBuilder: (context, index) {
                return _buildMenuList(allMenus[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ================= CATEGORY =================
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
              color: index == 0 ? colorBrown : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.pink.withOpacity(0.2),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              categories[index],
              style: TextStyle(
                color: index == 0 ? Colors.white : colorBrown,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= MENU LIST =================
  Widget _buildMenuList(Map<String, String> menu) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.pink.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            // GAMBAR
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                menu["img"]!,
                width: 85,
                height: 85,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 14),

            // TEXT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu["nama"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: colorBrown,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    menu["desc"]!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    menu["harga"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: colorBrown,
                    ),
                  ),
                ],
              ),
            ),

            // BUTTON +
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorBrown,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}