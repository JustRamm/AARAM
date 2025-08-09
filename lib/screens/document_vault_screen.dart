import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/theme_provider.dart';
import 'document_detail_screen.dart';

class DocumentVaultScreen extends StatefulWidget {
  const DocumentVaultScreen({super.key});

  @override
  State<DocumentVaultScreen> createState() => _DocumentVaultScreenState();
}

class _DocumentVaultScreenState extends State<DocumentVaultScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All',
    'ID Proofs',
    'Licenses',
    'Certificates',
    'Tax Documents',
  ];

  final List<Map<String, dynamic>> _documents = [
    {
      'id': '1',
      'title': 'Aadhaar Card',
      'category': 'ID Proofs',
      'documentNumber': 'XXXX-XXXX-1234',
      'expiryDate': 'Lifetime',
      'issueDate': '2020-03-15',
      'status': 'Active',
      'icon': Icons.fingerprint,
      'color': Colors.orange,
      'officialWebsite': 'https://uidai.gov.in',
    },
    {
      'id': '2',
      'title': 'PAN Card',
      'category': 'ID Proofs',
      'documentNumber': 'ABCDE1234F',
      'expiryDate': 'Lifetime',
      'issueDate': '2018-07-22',
      'status': 'Active',
      'icon': Icons.credit_card,
      'color': Colors.blue,
      'officialWebsite': 'https://www.incometax.gov.in',
    },
    {
      'id': '3',
      'title': 'Driving License',
      'category': 'Licenses',
      'documentNumber': 'DL-0120140149646',
      'expiryDate': '2025-12-31',
      'issueDate': '2020-01-15',
      'status': 'Active',
      'icon': Icons.drive_eta,
      'color': Colors.green,
      'officialWebsite': 'https://sarathi.parivahan.gov.in',
    },
    {
      'id': '4',
      'title': 'Passport',
      'category': 'ID Proofs',
      'documentNumber': 'A1234567',
      'expiryDate': '2030-05-20',
      'issueDate': '2020-05-20',
      'status': 'Active',
      'icon': Icons.book,
      'color': Colors.purple,
      'officialWebsite': 'https://passportindia.gov.in',
    },
    {
      'id': '5',
      'title': 'Voter ID',
      'category': 'ID Proofs',
      'documentNumber': 'ABC1234567',
      'expiryDate': 'Lifetime',
      'issueDate': '2019-11-10',
      'status': 'Active',
      'icon': Icons.how_to_vote,
      'color': Colors.red,
      'officialWebsite': 'https://voterportal.eci.gov.in',
    },
    {
      'id': '6',
      'title': 'Birth Certificate',
      'category': 'Certificates',
      'documentNumber': 'BC-2020-001234',
      'expiryDate': 'Lifetime',
      'issueDate': '2020-08-15',
      'status': 'Active',
      'icon': Icons.description,
      'color': Colors.teal,
      'officialWebsite': 'https://crsorgi.gov.in',
    },
    {
      'id': '7',
      'title': 'Income Tax Return',
      'category': 'Tax Documents',
      'documentNumber': 'ITR-2023-24',
      'expiryDate': 'N/A',
      'issueDate': '2023-07-31',
      'status': 'Filed',
      'icon': Icons.receipt_long,
      'color': Colors.indigo,
      'officialWebsite': 'https://www.incometax.gov.in',
    },
    {
      'id': '8',
      'title': 'GST Registration',
      'category': 'Tax Documents',
      'documentNumber': '27AABCA1234A1Z5',
      'expiryDate': 'N/A',
      'issueDate': '2021-04-01',
      'status': 'Active',
      'icon': Icons.business,
      'color': Colors.deepOrange,
      'officialWebsite': 'https://www.gst.gov.in',
    },
  ];

  List<Map<String, dynamic>> get _filteredDocuments {
    return _documents.where((doc) {
      final matchesCategory = _selectedCategory == 'All' || doc['category'] == _selectedCategory;
      final matchesSearch = _searchQuery.isEmpty || 
          doc['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
          doc['documentNumber'].toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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
              'Document Vault',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E3A8A),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF1E3A8A)),
            onPressed: () {
              // TODO: Add new document functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search documents...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Documents List
          Expanded(
            child: _filteredDocuments.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredDocuments.length,
                    itemBuilder: (context, index) {
                      final document = _filteredDocuments[index];
                      return _buildDocumentCard(document);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: document['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            document['icon'],
            color: document['color'],
            size: 24,
          ),
        ),
        title: Text(
          document['title'],
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Number: ${document['documentNumber']}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getStatusColor(document['status']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    document['status'],
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: _getStatusColor(document['status']),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Expires: ${document['expiryDate']}',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.grey),
          onSelected: (value) {
            _handleDocumentAction(value, document);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility, size: 16),
                  SizedBox(width: 8),
                  Text('View Details'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'download',
              child: Row(
                children: [
                  Icon(Icons.download, size: 16),
                  SizedBox(width: 8),
                  Text('Download'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 16),
                  SizedBox(width: 8),
                  Text('Share'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'official',
              child: Row(
                children: [
                  Icon(Icons.language, size: 16),
                  SizedBox(width: 8),
                  Text('Official Website'),
                ],
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DocumentDetailScreen(document: document),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No documents found',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filter criteria',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'expired':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      case 'filed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _handleDocumentAction(String action, Map<String, dynamic> document) {
    switch (action) {
      case 'view':
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DocumentDetailScreen(document: document),
          ),
        );
        break;
      case 'download':
        // TODO: Implement download functionality
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Downloading ${document['title']}...')),
        );
        break;
      case 'share':
        // TODO: Implement share functionality
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sharing ${document['title']}...')),
        );
        break;
      case 'official':
        _launchOfficialWebsite(document['officialWebsite']);
        break;
    }
  }

  void _launchOfficialWebsite(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open website: $url'),
        ),
      );
    }
  }
}
