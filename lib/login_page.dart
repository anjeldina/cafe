import 'dart:ui';
import 'package:flutter/material.dart';
// WAJIB IMPORT HOME PAGE BIAR NAVIGATION JALAN
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  // Luxury Palette
  static const Color colorCream = Color(0xFFFDF8F2);
  static const Color colorBrown = Color(0xFF2D1B14); 
  static const Color colorGold = Color(0xFFC6A664);  
  static const Color colorSoftText = Color(0xFF7A6D61);

  bool _isVisible = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isVisible = true);
    });

    _emailFocus.addListener(() => setState(() {}));
    _passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _email.dispose();
    _password.dispose();
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _login() async {
    if (_email.text.isEmpty || _password.text.isEmpty) {
      _showCustomToast("Silakan lengkapi data Anda");
      return;
    }
    
    setState(() => _isLoading = true);
    
    // Simulasi loading biar kelihatan premium
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    setState(() => _isLoading = false);
    
    // PINDAH KE HOME & USERNAME DIAMBIL DARI INPUT EMAIL
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(
        builder: (context) => HomePage(username: _email.text)
      )
    );
  }

  void _showCustomToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: colorBrown,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCream,
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    // --- LOGO FLOATING ---
                    AnimatedBuilder(
                      animation: _floatingController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, 10 * _floatingController.value),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: colorBrown.withValues(alpha: 0.15),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/images/logo.png', // Pastikan file logo ada di folder assets
                              width: 160,
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 25),
                    
                    const Text(
                      "CAFELLA",
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.w900, 
                        letterSpacing: 10, 
                        color: colorBrown,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(width: 50, height: 2, color: colorGold),

                    const SizedBox(height: 45),

                    // Luxury Glass Card
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 1000),
                      opacity: _isVisible ? 1 : 0,
                      child: _buildLuxuryCard(),
                    ),
                    
                    const SizedBox(height: 30),
                    _buildFooter(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLuxuryCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white.withValues(alpha: 0.9), Colors.white.withValues(alpha: 0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1.5),
          ),
          child: Column(
            children: [
              _buildModernInput(
                controller: _email,
                focus: _emailFocus,
                label: "Email Address",
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 20),
              _buildModernInput(
                controller: _password,
                focus: _passFocus,
                label: "Secure Password",
                icon: Icons.lock_person_outlined,
                isPassword: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?", 
                    style: TextStyle(color: colorSoftText, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              _buildPremiumButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernInput({
    required TextEditingController controller,
    required FocusNode focus,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    bool active = focus.hasFocus;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: active ? colorGold : colorBrown.withValues(alpha: 0.1),
          width: 1.2,
        ),
      ),
      child: TextField(
        controller: controller,
        focusNode: focus,
        obscureText: isPassword ? _obscurePassword : false,
        style: const TextStyle(fontWeight: FontWeight.w600, color: colorBrown),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: active ? colorBrown : colorSoftText, fontSize: 13),
          prefixIcon: Icon(icon, color: active ? colorGold : colorSoftText, size: 20),
          suffixIcon: isPassword ? IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded, size: 18, color: colorBrown),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildPremiumButton() {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
         BoxShadow(color: colorBrown.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))
        ],
      ),
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorBrown,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 0,
        ),
        child: _isLoading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: colorGold, strokeWidth: 2))
            : const Text("SIGN IN", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900, letterSpacing: 1.5)),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? ", style: TextStyle(color: colorSoftText)),
        GestureDetector(
          onTap: () {},
          child: const Text("SIGN UP", style: TextStyle(color: colorBrown, fontWeight: FontWeight.w900)),
        ),
      ],
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: CircleAvatar(radius: 120, backgroundColor: colorBrown.withValues(alpha: 0.03)),
            ),
            Positioned(
              bottom: 100,
              left: -30,
              child: Icon(Icons.blur_on, size: 150, color: colorGold.withValues(alpha: 0.04)),
            ),
          ],
        );
      },
    );
  }
}