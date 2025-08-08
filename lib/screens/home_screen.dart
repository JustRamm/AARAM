import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive_utils.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';
import 'ai_chatbot_screen.dart';
import 'document_vault_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/icons/ChatGPT Image Aug 8, 2025, 04_57_08 PM.png',
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 12),
            Text(
              themeProvider.getText('dashboard'),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A8A),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const DocumentVaultScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E3A8A).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.folder_open,
                  size: 24,
                  color: Color(0xFF1E3A8A),
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none, color: Color(0xFF1E3A8A)),
                if (true)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 12,
                        minHeight: 12,
                      ),
                      child: const Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
              ],
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            },
          ),
        ],
      ),
      body: _buildBody(authProvider, themeProvider),
      bottomNavigationBar: _buildBottomNavigationBar(themeProvider),
    );
  }

  Widget _buildBody(AuthProvider authProvider, ThemeProvider themeProvider) {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent(authProvider, themeProvider);
      case 1:
        return const AiChatbotScreen();
      case 2:
        return const ProfileScreen();
      default:
        return _buildHomeContent(authProvider, themeProvider);
    }
  }

  Widget _buildHomeContent(AuthProvider authProvider, ThemeProvider themeProvider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          _buildWelcomeSection(authProvider, themeProvider),
          
          const SizedBox(height: 24),
          
          // Expiry Overview
          _buildExpiryOverview(themeProvider),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          _buildQuickActions(themeProvider),
          
          const SizedBox(height: 24),
          
          // Recent Applications
          _buildRecentApplications(themeProvider),
          
          const SizedBox(height: 24),
          
          // Government Documents Grid
          _buildGovernmentDocumentsGrid(themeProvider),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection(AuthProvider authProvider, ThemeProvider themeProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${themeProvider.getText('welcome_back')}, ${authProvider.userName ?? 'User'}!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            themeProvider.getText('manage_documents'),
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiryOverview(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          themeProvider.getText('document_expiry_overview'),
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildExpiryCard(
                title: themeProvider.getText('expiring_soon'),
                count: '3',
                color: Colors.orange,
                icon: Icons.warning,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildExpiryCard(
                title: themeProvider.getText('active'),
                count: '12',
                color: Colors.green,
                icon: Icons.check_circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildExpiryCard(
                title: themeProvider.getText('expired'),
                count: '1',
                color: Colors.red,
                icon: Icons.error,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpiryCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            count,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          themeProvider.getText('quick_actions'),
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                text: themeProvider.getText('renew_now'),
                icon: Icons.refresh,
                color: Colors.blue,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                text: themeProvider.getText('apply_new'),
                icon: Icons.add,
                color: Colors.green,
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                text: themeProvider.getText('track_status'),
                icon: Icons.track_changes,
                color: Colors.purple,
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentApplications(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          themeProvider.getText('recent_applications'),
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        Column(
          children: [
            _buildApplicationItem(
              title: '${themeProvider.getText('aadhaar_card')} Update',
              status: themeProvider.getText('in_progress'),
              date: '2 days ago',
              statusColor: Colors.orange,
            ),
            const SizedBox(height: 12),
            _buildApplicationItem(
              title: '${themeProvider.getText('pan_card')} Renewal',
              status: themeProvider.getText('completed_status'),
              date: '1 week ago',
              statusColor: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildApplicationItem(
              title: themeProvider.getText('driving_license'),
              status: themeProvider.getText('pending'),
              date: '3 days ago',
              statusColor: Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApplicationItem({
    required String title,
    required String status,
    required String date,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGovernmentDocumentsGrid(ThemeProvider themeProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          themeProvider.getText('government_documents'),
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: _governmentDocuments.length,
          itemBuilder: (context, index) {
            return _buildDocumentCard(_governmentDocuments[index], themeProvider);
          },
        ),
      ],
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document, ThemeProvider themeProvider) {
    return GestureDetector(
      onTap: () async {
        if (document['officialWebsite'] != null) {
          final url = Uri.parse(document['officialWebsite']);
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open ${document['title']} website')),
            );
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              document['icon'],
              color: document['color'],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              document['title'],
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(ThemeProvider themeProvider) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF1E3A8A),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: themeProvider.getText('home'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat),
          label: themeProvider.getText('ai_chat'),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: themeProvider.getText('profile'),
        ),
      ],
    );
  }

  final List<Map<String, dynamic>> _governmentDocuments = [
    {
      'title': 'Aadhaar',
      'icon': Icons.fingerprint,
      'color': Colors.orange,
      'officialWebsite': 'https://uidai.gov.in',
    },
    {
      'title': 'PAN Card',
      'icon': Icons.credit_card,
      'color': Colors.blue,
      'officialWebsite': 'https://www.incometax.gov.in',
    },
    {
      'title': 'Driving License',
      'icon': Icons.drive_eta,
      'color': Colors.green,
      'officialWebsite': 'https://sarathi.parivahan.gov.in',
    },
    {
      'title': 'Passport',
      'icon': Icons.book,
      'color': Colors.purple,
      'officialWebsite': 'https://passportindia.gov.in',
    },
    {
      'title': 'Voter ID',
      'icon': Icons.how_to_vote,
      'color': Colors.red,
      'officialWebsite': 'https://voterportal.eci.gov.in',
    },
    {
      'title': 'Birth Certificate',
      'icon': Icons.description,
      'color': Colors.teal,
      'officialWebsite': 'https://crsorgi.gov.in',
    },
  ];
} 