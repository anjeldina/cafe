import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, String>> items;
  final VoidCallback onCheckoutSuccess;

  const CheckoutPage({
    super.key,
    required this.items,
    required this.onCheckoutSuccess,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  static const Color colorBrown = Color(0xFF2E1B14);
  static const Color colorCream = Color(0xFFFDF8F2);
  static const Color colorGold = Color(0xFFC6A664);
  static const Color colorGrey = Color(0xFF9E9E9E);

  List<Map<String, dynamic>> cart = [];

  String selectedPayment = "Transfer Bank";
  String selectedOrderType = "Delivery";

  final TextEditingController alamatController = TextEditingController();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hpController = TextEditingController();

  final List<Map<String, dynamic>> paymentMethods = [
    {"name": "Transfer Bank", "icon": Icons.account_balance_outlined},
    {"name": "E-Wallet", "icon": Icons.account_balance_wallet_outlined},
    {"name": "Kartu Kredit", "icon": Icons.credit_card_outlined},
    {"name": "COD", "icon": Icons.local_shipping_outlined},
  ];

  final format = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    _syncCart();
  }

  void _syncCart() {
    cart = widget.items.map((item) {
      int harga = int.parse(
        item["harga"]!.replaceAll(RegExp(r'[^0-9]'), ''),
      );

      return {
        "nama": item["nama"],
        "harga": harga,
        "img": item["img"],
        "qty": 1,
      };
    }).toList();
  }

  int getSubtotal() {
    return cart.fold(
      0,
      (sum, item) =>
          sum + ((item["harga"] as int) * (item["qty"] as int)),
    );
  }

  @override
  Widget build(BuildContext context) {
    int subtotal = getSubtotal();
    int ongkir =
        selectedOrderType == "Pickup" ? 0 : (subtotal == 0 ? 0 : 5000);
    int total = subtotal + ongkir;

    return Scaffold(
      backgroundColor: colorCream,
      bottomNavigationBar:
          _buildSummaryPanel(subtotal, ongkir, total),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: colorBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: cart.isEmpty
          ? _buildEmptyState()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                const SizedBox(height: 10),

                _sectionTitle("Pesanan Anda"),
                ...cart
                    .asMap()
                    .entries
                    .map((entry) =>
                        _buildItemCard(entry.value, entry.key))
                    .toList(),

                const SizedBox(height: 20),

                _sectionTitle("Tipe Pesanan"),
                _buildOrderType(),

                const SizedBox(height: 20),

                if (selectedOrderType == "Delivery")
                  _buildAlamatInput(),

                const SizedBox(height: 20),

                _sectionTitle("Metode Pembayaran"),
                _buildPaymentGrid(),

                const SizedBox(height: 120),
              ],
            ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: colorGrey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item["img"],
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item["nama"],
                    style:
                        const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(
                  format.format(item["harga"]),
                  style: const TextStyle(
                    color: colorGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildQtyControl(index),
        ],
      ),
    );
  }

  Widget _buildQtyControl(int index) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (cart[index]["qty"] > 1) {
                cart[index]["qty"]--;
              } else {
                cart.removeAt(index);
              }
            });
          },
          child: const Icon(Icons.remove),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(cart[index]["qty"].toString()),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              cart[index]["qty"]++;
            });
          },
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

  Widget _buildOrderType() {
    return Row(
      children: [
        Expanded(child: _orderBtn("Pickup")),
        const SizedBox(width: 10),
        Expanded(child: _orderBtn("Delivery")),
      ],
    );
  }

  Widget _orderBtn(String type) {
    bool active = selectedOrderType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedOrderType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: active ? colorBrown : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(
              color: active ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlamatInput() {
    return Column(
      children: [
        _input(namaController, "Nama Penerima"),
        const SizedBox(height: 10),
        _input(hpController, "No HP", TextInputType.phone),
        const SizedBox(height: 10),
        _input(alamatController, "Alamat Lengkap", TextInputType.text, 2),
      ],
    );
  }

  Widget _input(TextEditingController c, String hint,
      [TextInputType type = TextInputType.text, int max = 1]) {
    return TextField(
      controller: c,
      keyboardType: type,
      maxLines: max,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPaymentGrid() {
    return Column(
      children: paymentMethods.map((item) {
        bool active = selectedPayment == item["name"];

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedPayment = item["name"];
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: active ? colorBrown : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: active ? colorBrown : Colors.grey.shade300,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  item["icon"],
                  color: active ? Colors.white : Colors.black87,
                ),
                const SizedBox(width: 12),
                Text(
                  item["name"],
                  style: TextStyle(
                    color: active ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSummaryPanel(int subtotal, int ongkir, int total) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _rowInfo("Subtotal", format.format(subtotal)),
            _rowInfo("Ongkir", format.format(ongkir)),
            const Divider(),
            _rowInfo("Total", format.format(total)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (selectedOrderType == "Delivery") {
                  if (namaController.text.isEmpty ||
                      hpController.text.isEmpty ||
                      alamatController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Lengkapi data alamat dulu"),
                      ),
                    );
                    return;
                  }
                }
                _showSuccess();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorBrown,
                foregroundColor: Colors.white,
                minimumSize:
                    const Size(double.infinity, 55),
              ),
              child: const Text("Bayar Sekarang"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Text("Keranjang masih kosong"),
    );
  }

  void _showSuccess() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Success",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (_, _, _) => const SizedBox(),
      transitionBuilder: (context, animation, _, _) {
        return Transform.scale(
          scale: Curves.easeOutBack.transform(animation.value),
          child: Opacity(
            opacity: animation.value,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.withValues(alpha: 0.1),
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 60,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Pesanan Berhasil!",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Pesanan kamu sedang diproses.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onCheckoutSuccess();
                            setState(() {
                              cart.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorBrown,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Kembali"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}