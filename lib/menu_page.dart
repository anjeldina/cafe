import 'dart:ui';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  final Function(Map<String, String>) onAddToCart;
  final VoidCallback onResetCart;

  const MenuPage({super.key, required this.onAddToCart, required this.onResetCart});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  static const Color colorBrown = Color(0xFF2E1B14);
  static const Color colorCream = Color(0xFFFDF8F2);
  static const Color colorGold = Color(0xFFC6A664);

  String selectedCategory = "Semua";

  final List<Map<String, String>> allMenus = const [
    {
      "nama": "Classic Choco",
      "harga": "Rp19.000",
      "img": "assets/images/cc.jpg",
      "desc": "Coklat murni premium yang dipadukan dengan susu segar creamy. Cocok untuk menemani hari santai Anda.",
      "category": "Coklat"
    },
    {
      "nama": "Choco Mood",
      "harga": "Rp19.000",
      "img": "assets/images/cm.jpg",
      "desc": "Kombinasi coklat hitam dengan sentuhan rahasia yang dijamin bisa memperbaiki mood seketika.",
      "category": "Coklat"
    },
    {
      "nama": "Choco Oreo Blast",
      "harga": "Rp17.000",
      "img": "assets/images/cob.jpg",
      "desc": "Ledakan rasa coklat yang berpadu dengan taburan oreo renyah di setiap tegukannya.",
      "category": "Coklat"
    },
    {
      "nama": "Cloud Caramel Coffee",
      "harga": "Rp22.000",
      "img": "assets/images/m1.jpg",
      "desc": "Perpaduan creamy susu dingin dengan foam kopi lembut di atasnya, disiram saus karamel yang manis dan aromatik.",
      "category": "Kopi"
    },
    {
      "nama": "Caramel Cream Latte",
      "harga": "Rp27.000",
      "img": "assets/images/m2.jpg",
      "desc": "Espresso lembut berpadu dengan susu creamy dan saus karamel manis, disempurnakan dengan whipped cream tebal di atasnya. Rasanya rich, manis, dan super indulgent—cocok buat kamu yang suka minuman kopi dessert.",
      "category": "Kopi"
    },
    {
      "nama": "Classic Iced Latte",
      "harga": "Rp26.000",
      "img": "assets/images/m3.jpg",
      "desc": "Perpaduan espresso bold dengan susu segar dan es batu, menghadirkan rasa kopi yang seimbang, ringan, dan menyegarkan. Pilihan sempurna untuk kamu yang suka kopi simpel tapi tetap nikmat.",
      "category": "Kopi"
    },
    {
      "nama": "Caramel Crunch Latte",
      "harga": "Rp27.000",
      "img": "assets/images/m4.jpg",
      "desc": "Kombinasi espresso dan susu creamy dengan sentuhan saus karamel, ditambah topping crunchy yang manis dan gurih. Memberikan sensasi minum kopi yang lembut sekaligus renyah di setiap tegukan.",
      "category": "kopi"
    },
    {
      "nama": "Berry Velvet Pudding",
      "harga": "Rp25.000",
      "img": "assets/images/c1.jpg",
      "desc": "Dessert lembut dengan tekstur creamy dan halus, disajikan dengan taburan gula halus serta topping buah beri segar yang memberikan perpaduan rasa manis dan sedikit asam. Tampilannya elegan dan cocok sebagai hidangan penutup premium.",
      "category": "Cake"
    },
    {
      "nama": "Bluberry Cloud Croisant",
      "harga": "Rp27.000",
      "img": "assets/images/c2.jpg",
      "desc": "Croissant renyah dengan lapisan luar buttery, dipadukan krim lembut di atasnya dan topping blueberry segar. Memiliki perpaduan rasa manis, creamy, dan sedikit fruity.",
      "category": "Cake"
    },
    {
      "nama": "Caramel Bliss Cheescake",
      "harga": "Rp28.000",
      "img": "assets/images/c3.jpg",
      "desc": "Cheesecake lembut dengan tekstur creamy yang lumer di mulut, dipadukan lapisan saus karamel manis di atasnya dan base biskuit yang renyah. Cocok untuk pencinta dessert dengan rasa manis yang elegan dan premium.",
      "category": "Cake"
    },
    {
      "nama": "Classic Velvet Tiramisu",
      "harga": "Rp30.000",
      "img": "assets/images/c4.jpg",
      "desc": "Dessert khas Italia dengan lapisan biskuit kopi yang lembut, dipadukan krim mascarpone creamy dan taburan cokelat bubuk di atasnya.",
      "category": "Cake"
    },
    {
      "nama": "Golden Caramel Flan",
      "harga": "Rp26.000",
      "img": "assets/images/c5.jpg",
      "desc": "Puding custard lembut dengan tekstur silky, disiram saus karamel manis yang kaya rasa dan dihiasi topping kacang untuk tambahan tekstur. Memiliki rasa creamy, manis, dan elegan, cocok sebagai dessert premium.",
      "category": "Cake"
    },
    {
      "nama": "Chocolate Strawberry Slice",
      "harga": "Rp30.000",
      "img": "assets/images/c6.jpg",
      "desc": "Kue cokelat berlapis dengan krim lembut di setiap sela, dilapisi saus cokelat yang meleleh di atasnya dan dihias stroberi segar. Perpaduan rasa manis, sedikit asam dari stroberi, dan tekstur lembut.",
      "category": "Cake"
    },
    {
      "nama": "Chocolate Lava Cake",
      "harga": "Rp32.000",
      "img": "assets/images/c7.jpg",
      "desc": "Kue cokelat hangat bertekstur lembut dengan bagian tengah yang lumer (lava), disajikan bersama es krim vanila dingin, saus cokelat, serta topping raspberry dan daun mint. Perpaduan panas dan dingin ini bikin rasanya kaya, manis, dan sedikit segar.",
      "category": "Cake"
    },
    {
      "nama": "Chocolate Mud Cake Slice",
      "harga": "Rp27.000",
      "img": "assets/images/c8.jpg",
      "desc": "Potongan kue cokelat padat dengan tekstur lembut dan sedikit fudgy, ditaburi bubuk kakao serta choco chips di atasnya. Rasanya kaya cokelat, tidak terlalu manis, cocok untuk pecinta dessert yang simpel tapi elegan.",
      "category": "Cake"
    },
    {
      "nama": "Banana Chocolate Waffle",
      "harga": "Rp30.000",
      "img": "assets/images/c9.jpg",
      "desc": "Waffle renyah di luar dan lembut di dalam, disajikan dengan irisan pisang segar, sirup cokelat, dan taburan oat. Perpaduan rasa manis dan tekstur yang beragam membuatnya cocok jadi menu sarapan atau dessert santai.",
      "category": "Cake"
    },
  ];

  List<Map<String, String>> get filteredMenus {
    if (selectedCategory == "Semua") return allMenus;
    return allMenus.where((menu) => menu["category"] == selectedCategory).toList();
  }

  void _showProductDetail(BuildContext context, Map<String, String> menu) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      child: Image.asset(menu["img"]!, height: 350, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(color: colorCream, borderRadius: BorderRadius.circular(12)),
                                child: Text(menu["category"]!, style: const TextStyle(color: colorBrown, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                              Row(
                                children: const [
                                  Icon(Icons.star, color: Colors.orange, size: 18),
                                  SizedBox(width: 4),
                                  Text("4.9", style: TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(menu["nama"]!, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: colorBrown)),
                          const SizedBox(height: 8),
                          Text(menu["harga"]!, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorGold)),
                          const SizedBox(height: 20),
                          const Text("Deskripsi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          const SizedBox(height: 8),
                          Text(menu["desc"]!, style: TextStyle(color: Colors.grey[600], fontSize: 15, height: 1.6)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.white.withValues(alpha: 0), Colors.white]),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorBrown,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        widget.onAddToCart(menu);
                        Navigator.pop(context);
                      },
                      child: const Text("Tambah ke Keranjang", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCream,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            automaticallyImplyLeading: false,
            backgroundColor: colorCream,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text("Menu Eksklusif", style: TextStyle(color: colorBrown, fontWeight: FontWeight.w900, fontSize: 20)),
            ),
          ),
          SliverToBoxAdapter(child: _buildCategoryList()),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildMenuList(context, filteredMenus[index]),
                childCount: filteredMenus.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    List<String> categories = ["Semua", "Coklat", "Kopi", "Cake"];
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isActive = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: isActive ? colorBrown : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [if (isActive) BoxShadow(color: colorBrown.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))],
              ),
              alignment: Alignment.center,
              child: Text(
                categories[index],
                style: TextStyle(color: isActive ? Colors.white : colorBrown, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, Map<String, String> menu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: () => _showProductDetail(context, menu),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 10))],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(menu["img"]!, width: 100, height: 100, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(menu["nama"]!, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 17, color: colorBrown)),
                    const SizedBox(height: 4),
                    Text(menu["desc"]!, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 12, color: Colors.grey[500], height: 1.4)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(menu["harga"]!, style: const TextStyle(fontWeight: FontWeight.w900, color: colorGold, fontSize: 16)),
                        GestureDetector(
                          onTap: () {
                            widget.onAddToCart(menu);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${menu["nama"]} ditambahkan!"), behavior: SnackBarBehavior.floating));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(color: colorBrown, shape: BoxShape.circle),
                            child: const Icon(Icons.add, color: Colors.white, size: 20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}