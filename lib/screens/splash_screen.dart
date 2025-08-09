import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive_utils.dart';
import 'welcome_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late AnimationController _rotateController;
  late AnimationController _bounceController;
  late AnimationController _textController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    _scaleController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _slideController = AnimationController(duration: const Duration(milliseconds: 1800), vsync: this);
    _rotateController = AnimationController(duration: const Duration(milliseconds: 2500), vsync: this);
    _bounceController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _textController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
    
    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );
    
    _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.bounceOut),
    );
    
    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    _startAnimations();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    _rotateController.dispose();
    _bounceController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _startAnimations() async {
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _rotateController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    _bounceController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 10000));
    if (mounted) {
      _navigateToNextScreen();
    }
  }

  void _navigateToNextScreen() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFF1E3A8A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A),
              Color(0xFF3B82F6),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo with animations
                AnimatedBuilder(
                  animation: Listenable.merge([_fadeController, _scaleController, _rotateController]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Transform.rotate(
                        angle: _rotateAnimation.value * 0.1,
                        child: Opacity(
                          opacity: _fadeAnimation.value,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 30,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'assets/icons/ChatGPT Image Aug 8, 2025, 04_57_08 PM.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
                // Title with slide animation
                AnimatedBuilder(
                  animation: Listenable.merge([_slideController, _fadeController]),
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Text(
                          'AARAM',
                          style: GoogleFonts.poppins(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // Subtitle with bounce animation
                AnimatedBuilder(
                  animation: Listenable.merge([_bounceController, _fadeController]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.8 + (_bounceAnimation.value * 0.2),
                      child: Opacity(
                        opacity: _fadeAnimation.value,
                        child: Text(
                          themeProvider.getText('document_manager'),
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 60),
                // Loading indicator with text animation
                AnimatedBuilder(
                  animation: Listenable.merge([_textController, _fadeController]),
                  builder: (context, child) {
                    return Opacity(
                      opacity: _textAnimation.value,
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            themeProvider.getText('loading_documents'),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 