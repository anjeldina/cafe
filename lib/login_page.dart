import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color colorPink = Color(0xFFFFC7C7);
  static const Color colorBrown = Color(0xFF3C2218);

  bool _isVisible = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: _isVisible ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 40),

                // ☕ LOGO
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: colorBrown,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.coffee, color: Colors.white, size: 28),
                  ),
                ),

                const SizedBox(height: 40),

                // 🔥 TITLE
                const Text(
                  "Masuk ke akun kamu",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorBrown,
                  ),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Nikmati minuman coklat favoritmu ☕",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                // EMAIL
                _buildFloatingTextField(
                  label: 'Email',
                  icon: Icons.email_outlined,
                ),

                const SizedBox(height: 25),

                // PASSWORD
                _buildFloatingTextField(
                  label: 'Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),

                const SizedBox(height: 10),

                // LUPA PASSWORD
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Lupa password?",
                      style: TextStyle(color: colorBrown),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // BUTTON LOGIN
                _buildButton(),

                const Spacer(),

                // REGISTER
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Belum punya akun? ",
                      children: [
                        TextSpan(
                          text: "Daftar",
                          style: const TextStyle(
                            color: colorBrown,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= TEXTFIELD =================
  Widget _buildFloatingTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(primary: colorBrown),
      ),
      child: TextField(
        obscureText: isPassword ? _obscurePassword : false,
        cursorColor: colorBrown,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.black54,
          ),
          floatingLabelStyle: const TextStyle(
            color: colorBrown,
            fontWeight: FontWeight.bold,
          ),

          prefixIcon: Icon(icon, color: colorBrown),

          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: colorBrown,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : null,

          filled: true,
          fillColor: Colors.grey.shade100,

          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: colorBrown, width: 1.5),
          ),
        ),
      ),
    );
  }

  // ================= BUTTON =================
  Widget _buildButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBrown,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: const Text(
          "MASUK",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}