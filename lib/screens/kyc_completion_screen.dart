import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../utils/responsive_utils.dart';
import 'home_screen.dart';

class KycCompletionScreen extends StatefulWidget {
  const KycCompletionScreen({super.key});

  @override
  State<KycCompletionScreen> createState() => _KycCompletionScreenState();
}

class _KycCompletionScreenState extends State<KycCompletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Rahul Kumar Sharma');
  final _emailController = TextEditingController(text: 'rahul.sharma@email.com');
  final _phoneController = TextEditingController(text: '+91 98765 43210');
  final _aadhaarController = TextEditingController(text: '1234 5678 9012');
  final _panController = TextEditingController(text: 'ABCDE1234F');
  final _addressController = TextEditingController(
    text: '123, Green Park, New Delhi - 110016',
  );
  
  bool _isLoading = false;
  bool _isNameVerified = true;
  bool _isEmailVerified = true;
  bool _isPhoneVerified = true;
  bool _isAadhaarVerified = true;
  bool _isPanVerified = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _aadhaarController.dispose();
    _panController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _completeKyc() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate KYC completion
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('KYC completed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('KYC completion failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E3A8A)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E3A8A),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1E3A8A).withOpacity(0.3),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                                                     child: Image.asset(
                             'assets/icons/ChatGPT Image Aug 8, 2025, 04_57_08 PM.png',
                             width: 80,
                             height: 80,
                             fit: BoxFit.cover,
                           ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Complete Your Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Verify your information from DigiLocker',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 40),
                
                // Success Message
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green.shade600,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Successfully fetched your documents from DigiLocker',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Personal Information Section
                _buildSectionTitle('Personal Information'),
                
                SizedBox(height: 16),
                
                // Name Field
                _buildVerifiedField(
                  controller: _nameController,
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person_outline,
                  isVerified: _isNameVerified,
                  onEdit: () {
                    setState(() {
                      _isNameVerified = false;
                    });
                  },
                ),
                
                SizedBox(height: 16),
                
                // Email Field
                _buildVerifiedField(
                  controller: _emailController,
                  labelText: 'Email Address',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  isVerified: _isEmailVerified,
                  onEdit: () {
                    setState(() {
                      _isEmailVerified = false;
                    });
                  },
                ),
                
                SizedBox(height: 16),
                
                // Phone Field
                _buildVerifiedField(
                  controller: _phoneController,
                  labelText: 'Phone Number',
                  hintText: 'Enter your phone number',
                  prefixIcon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  isVerified: _isPhoneVerified,
                  onEdit: () {
                    setState(() {
                      _isPhoneVerified = false;
                    });
                  },
                ),
                
                SizedBox(height: 24),
                
                // Document Information Section
                _buildSectionTitle('Document Information'),
                
                SizedBox(height: 16),
                
                // Aadhaar Field
                _buildVerifiedField(
                  controller: _aadhaarController,
                  labelText: 'Aadhaar Number',
                  hintText: 'Enter Aadhaar number',
                  prefixIcon: Icons.credit_card_outlined,
                  keyboardType: TextInputType.number,
                  isVerified: _isAadhaarVerified,
                  onEdit: () {
                    setState(() {
                      _isAadhaarVerified = false;
                    });
                  },
                ),
                
                SizedBox(height: 16),
                
                // PAN Field
                _buildVerifiedField(
                  controller: _panController,
                  labelText: 'PAN Number',
                  hintText: 'Enter PAN number',
                  prefixIcon: Icons.credit_card_outlined,
                  isVerified: _isPanVerified,
                  onEdit: () {
                    setState(() {
                      _isPanVerified = false;
                    });
                  },
                ),
                
                SizedBox(height: 16),
                
                // Address Field
                CustomTextField(
                  controller: _addressController,
                  labelText: 'Address',
                  hintText: 'Enter your address',
                  prefixIcon: Icons.location_on_outlined,
                  maxLines: 3,
                ),
                
                SizedBox(height: 32),
                
                // Complete KYC Button
                CustomButton(
                  text: 'Complete KYC',
                  onPressed: _completeKyc,
                  isLoading: _isLoading,
                  icon: Icons.verified,
                ),
                
                SizedBox(height: 16),
                
                // Info Text
                Text(
                  'Your information is encrypted and stored securely. You can update these details anytime from your profile.',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildVerifiedField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
    required bool isVerified,
    required VoidCallback onEdit,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 8),
            if (isVerified)
              Icon(
                Icons.verified,
                color: Colors.green.shade600,
                size: 16,
              ),
          ],
        ),
        SizedBox(height: 8),
        Stack(
          children: [
            CustomTextField(
              controller: controller,
              hintText: hintText,
              prefixIcon: prefixIcon,
              keyboardType: keyboardType,
              enabled: !isVerified,
            ),
            if (isVerified)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0.8),
                        Colors.white,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: const Color(0xFF1E3A8A),
                      size: 20,
                    ),
                    onPressed: onEdit,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
} 