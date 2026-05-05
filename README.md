# coffeshop

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# ☕ Project Documentation: CAFELLA PREMIUM APP

Dokumen ini adalah **Product Requirement Document (PRD) Teknis** yang menjelaskan arsitektur, fitur, dan perilaku sistem aplikasi Cafella secara mendalam.

---

## 1. IDENTITAS PRODUK
* **Nama Aplikasi:** Cafella
* **Versi:** 1.0.0 (Final Build)
* **UI Style:** Luxury Minimalist (Coffee & Chocolate Theme)
* **Developer Stack:** Flutter SDK, Dart Language.

---

## 2. ARSITEKTUR FILE (Project Structure)
Aplikasi ini dibangun dengan modularitas berbasis halaman (`pages`):
1.  **`splash_screen.dart`**: Entry point dengan logika *Timed-Navigation*.
2.  **`login_page.dart`**: Gerbang autentikasi dengan *AnimationController*.
3.  **`home_page.dart`**: Hub utama yang mengelola *State Keranjang* secara global.
4.  **`menu_page.dart`**: Katalog produk dinamis dengan sistem filter kategori.
5.  **`checkout_page.dart`**: Mesin kalkulasi biaya dan form transaksi.
6.  **`profile_page.dart`**: Manajemen session user dan logout.

---

## 3. SPESIFIKASI FITUR MENDALAM

### 3.1 Manajemen State & Data (Logic)
* **Cart System:** Menggunakan `List<Map<String, String>> cart` di level `HomePage`.
* **Data Passing:** Menggunakan *Callback Function* (`onAddToCart`) untuk mengirimkan data produk dari `MenuPage` kembali ke parent untuk disimpan.
* **Reset Logic:** Fungsi `_resetKeranjang()` dipicu setelah checkout berhasil untuk memastikan integritas data (keranjang kosong kembali).

### 3.2 UI & Animasi Teknis
* **Animation Engine:** Menggunakan `TickerProviderStateMixin` untuk sinkronisasi animasi 60fps.
* **Glassmorphism Effect:** Implementasi `BackdropFilter` dengan `ImageFilter.blur` pada Splash Screen dan Login.
* **Custom Navigation:** Navigasi bawah menggunakan `ClipRRect` dengan radius 35px untuk menciptakan efek melengkung modern (Floating Nav).

### 3.3 Logika Checkout
* **Auto-Kalkulasi:** * `Subtotal`: Iterasi harga dari daftar item keranjang.
    * `Shipping Fee`: Biaya flat tetap (Rp10.000).
    * `Grand Total`: Penjumlahan otomatis subtotal + biaya admin.
* **Formatting:** Menggunakan package `intl` (NumberFormat) untuk konversi angka menjadi format mata uang Rupiah.

---

## 4. SPESIFIKASI VISUAL (Luxury Palette)
Aplikasi menggunakan standar warna HEX berikut untuk menjaga konsistensi branding:
| Elemen | Kode Hex | Kegunaan |
| :--- | :--- | :--- |
| **Primary Brown** | `#2E1B14` | Tombol utama, Teks judul, Branding. |
| **Luxury Gold** | `#C6A664` | Harga, Aksen penting, Ikon aktif. |
| **Soft Cream** | `#FDF8F2` | Background utama agar mata tidak lelah. |
| **Accent Red** | `#FF5252` | Indikator logout dan tombol hapus. |

---

## 5. REYQUIREMENT SYSTEM (Persyaratan Teknis)
* **SDK:** Flutter >= 3.0.0
* **Dependencies:** `intl` (Format Mata Uang), `dart:ui` (Efek Blur).
* **Assets Path:** * `assets/images/logo.png`
    * `assets/images/[menu_items].jpg`

---

## 6. USER JOURNEY (Alur Perilaku)
1.  **Initial Load:** Animasi `ScaleTransition` pada Splash Screen selama 4 detik.
2.  **Auth Layer:** Validasi input pada Login Page sebelum memberikan akses ke Home.
3.  **Discovery:** User memfilter menu berdasarkan kategori (Coklat/Kopi).
4.  **Transaction:** User mengisi detail alamat dan metode pembayaran di Checkout Page.
5.  **Post-Transaction:** Muncul dialog sukses, dan aplikasi memicu `VoidCallback` untuk membersihkan data sementara.

---
*Dokumentasi ini dibuat untuk memenuhi standar profesional penulisan Product Requirement Document (PRD) dalam pengembangan perangkat lunak.*