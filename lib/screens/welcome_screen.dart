import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_button.dart';
import '../utils/responsive_utils.dart';
import '../providers/theme_provider.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'digilocker_connect_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              
              // Logo Section
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/icons/ChatGPT Image Aug 8, 2025, 04_57_08 PM.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Welcome Text
              Text(
                themeProvider.getText('welcome_to_aaram'),
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E3A8A),
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 12),
              
              Text(
                themeProvider.getText('your_personal_ai'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF1E3A8A).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  themeProvider.getText('app_subtitle'),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3A8A),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              
              const SizedBox(height: 48),
              
              // Features List
              _buildFeaturesList(),
              
              const SizedBox(height: 40),
              
              // Navigation Buttons
              Column(
                children: [
                  // Primary Action
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: CustomButton(
                      text: themeProvider.getText('get_started'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      icon: Icons.arrow_forward,
                      backgroundColor: const Color(0xFF1E3A8A),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Secondary Actions
                  Row(
                    children: [
                      Expanded(
                        child: _buildSecondaryButton(
                          text: themeProvider.getText('sign_up'),
                          icon: Icons.person_add,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSecondaryButton(
                          text: themeProvider.getText('digilocker'),
                          icon: Icons.folder_open,
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => const DigiLockerConnectScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Info Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: const Color(0xFF1E3A8A),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                                                 Expanded(
                           child: Text(
                             themeProvider.getText('choose_preferred_way'),
                             style: GoogleFonts.poppins(
                               fontSize: 12,
                               color: Colors.grey.shade700,
                               height: 1.4,
                             ),
                           ),
                         ),
                      ],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final features = [
      {
        'icon': Icons.shield,
        'title': themeProvider.getText('secure_document_storage'),
        'description': themeProvider.getText('secure_document_storage_desc'),
        'color': Colors.green,
      },
      {
        'icon': Icons.auto_awesome,
        'title': themeProvider.getText('ai_powered_form_filling'),
        'description': themeProvider.getText('ai_powered_form_filling_desc'),
        'color': Colors.blue,
      },
      {
        'icon': Icons.notifications_active,
        'title': themeProvider.getText('smart_expiry_tracking'),
        'description': themeProvider.getText('smart_expiry_tracking_desc'),
        'color': Colors.orange,
      },
      {
        'icon': Icons.track_changes,
        'title': themeProvider.getText('real_time_updates'),
        'description': themeProvider.getText('real_time_updates_desc'),
        'color': Colors.purple,
      },
    ];

    return Column(
      children: features.map((feature) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildFeatureItem(
            icon: feature['icon'] as IconData,
            title: feature['title'] as String,
            description: feature['description'] as String,
            color: feature['color'] as Color,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF1E3A8A).withOpacity(0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: const Color(0xFF1E3A8A),
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E3A8A),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 