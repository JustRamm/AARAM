import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive_utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF1E3A8A),
            size: ResponsiveUtils.getResponsiveIconSize(context, 
              mobile: 24, 
              tablet: 26, 
              desktop: 28
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
              ResponsiveUtils.isMobile(context) ? 18 : 
              ResponsiveUtils.isTablet(context) ? 20 : 22
            ),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E3A8A),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: const Color(0xFF1E3A8A),
              size: ResponsiveUtils.getResponsiveIconSize(context, 
                mobile: 24, 
                tablet: 26, 
                desktop: 28
              ),
            ),
            onPressed: () {
              _showNotificationOptions();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Section
          _buildFilterSection(),
          
          // Notifications List
          Expanded(
            child: _buildNotificationsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: ResponsiveUtils.getResponsivePadding(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Notifications',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
                ResponsiveUtils.isMobile(context) ? 14 : 
                ResponsiveUtils.isTablet(context) ? 16 : 18
              ),
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 12)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All', Icons.all_inclusive),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip('Expiry', Icons.warning),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip('Status', Icons.track_changes),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip('Updates', Icons.update),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip('Security', Icons.security),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IconData icon) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getPlatformAdjustedSpacing(context, 12),
          vertical: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(
            ResponsiveUtils.getResponsiveBorderRadius(context, 
              mobile: 20, 
              tablet: 24, 
              desktop: 28
            ),
          ),
          border: Border.all(
            color: isSelected ? const Color(0xFF1E3A8A) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: ResponsiveUtils.getResponsiveIconSize(context, 
                mobile: 16, 
                tablet: 18, 
                desktop: 20
              ),
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 6)),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
                  ResponsiveUtils.isMobile(context) ? 12 : 
                  ResponsiveUtils.isTablet(context) ? 13 : 14
                ),
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsList() {
    final filteredNotifications = _getFilteredNotifications();
    
    if (filteredNotifications.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: ResponsiveUtils.getResponsivePadding(context),
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return _buildNotificationItem(notification);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ResponsiveUtils.getResponsiveIconSize(context, 
              mobile: 80, 
              tablet: 100, 
              desktop: 120
            ),
            height: ResponsiveUtils.getResponsiveIconSize(context, 
              mobile: 80, 
              tablet: 100, 
              desktop: 120
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.getResponsiveIconSize(context, 
                  mobile: 40, 
                  tablet: 50, 
                  desktop: 60
                ),
              ),
            ),
            child: Icon(
              Icons.notifications_none,
              size: ResponsiveUtils.getResponsiveIconSize(context, 
                mobile: 40, 
                tablet: 50, 
                desktop: 60
              ),
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 24)),
          Text(
            'No notifications',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
                ResponsiveUtils.isMobile(context) ? 18 : 
                ResponsiveUtils.isTablet(context) ? 20 : 22
              ),
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
          Text(
            'You\'re all caught up!',
            style: GoogleFonts.poppins(
              fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
                ResponsiveUtils.isMobile(context) ? 14 : 
                ResponsiveUtils.isTablet(context) ? 16 : 18
              ),
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.getPlatformAdjustedSpacing(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ResponsiveUtils.getResponsiveBorderRadius(context, 
            mobile: 12, 
            tablet: 16, 
            desktop: 20
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: ResponsiveUtils.getResponsiveCardPadding(context),
        leading: Container(
          width: ResponsiveUtils.getResponsiveIconSize(context, 
            mobile: 48, 
            tablet: 56, 
            desktop: 64
          ),
          height: ResponsiveUtils.getResponsiveIconSize(context, 
            mobile: 48, 
            tablet: 56, 
            desktop: 64
          ),
          decoration: BoxDecoration(
            color: notification['color'].withOpacity(0.1),
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getResponsiveBorderRadius(context, 
                mobile: 12, 
                tablet: 16, 
                desktop: 20
              ),
            ),
          ),
          child: Icon(
            notification['icon'],
            color: notification['color'],
            size: ResponsiveUtils.getResponsiveIconSize(context, 
              mobile: 24, 
              tablet: 28, 
              desktop: 32
            ),
          ),
        ),
        title: Text(
          notification['title'],
          style: GoogleFonts.poppins(
            fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
              ResponsiveUtils.isMobile(context) ? 14 : 
              ResponsiveUtils.isTablet(context) ? 16 : 18
            ),
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 4)),
            Text(
              notification['message'],
              style: GoogleFonts.poppins(
                fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
                  ResponsiveUtils.isMobile(context) ? 12 : 
                  ResponsiveUtils.isTablet(context) ? 13 : 14
                ),
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: ResponsiveUtils.getResponsiveIconSize(context, 
                    mobile: 14, 
                    tablet: 16, 
                    desktop: 18
                  ),
                  color: Colors.grey.shade500,
                ),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 4)),
                Text(
                  notification['time'],
                  style: GoogleFonts.poppins(
                    fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
                      ResponsiveUtils.isMobile(context) ? 10 : 
                      ResponsiveUtils.isTablet(context) ? 11 : 12
                    ),
                    color: Colors.grey.shade500,
                  ),
                ),
                const Spacer(),
                if (notification['isUnread'])
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: notification['color'],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ],
        ),
        onTap: () {
          _handleNotificationTap(notification);
        },
      ),
    );
  }

  void _showNotificationOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            ResponsiveUtils.getResponsiveBorderRadius(context, 
              mobile: 20, 
              tablet: 24, 
              desktop: 28
            ),
          ),
        ),
      ),
      builder: (context) => Container(
        padding: ResponsiveUtils.getResponsivePadding(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 20)),
            _buildOptionItem(
              icon: Icons.mark_email_read,
              title: 'Mark all as read',
              onTap: () {
                Navigator.pop(context);
                _markAllAsRead();
              },
            ),
            _buildOptionItem(
              icon: Icons.delete_sweep,
              title: 'Clear all notifications',
              onTap: () {
                Navigator.pop(context);
                _clearAllNotifications();
              },
            ),
            _buildOptionItem(
              icon: Icons.settings,
              title: 'Notification settings',
              onTap: () {
                Navigator.pop(context);
                _openNotificationSettings();
              },
            ),
            SizedBox(height: ResponsiveUtils.getPlatformAdjustedSpacing(context, 20)),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFF1E3A8A),
        size: ResponsiveUtils.getResponsiveIconSize(context, 
          mobile: 22, 
          tablet: 24, 
          desktop: 26
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: ResponsiveUtils.getPlatformAdjustedFontSize(context, 
            ResponsiveUtils.isMobile(context) ? 14 : 
            ResponsiveUtils.isTablet(context) ? 16 : 18
          ),
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    // TODO: Handle notification tap based on type
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: ${notification['title']}'),
        backgroundColor: notification['color'],
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isUnread'] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _clearAllNotifications() {
    setState(() {
      _notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications cleared'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _openNotificationSettings() {
    // TODO: Navigate to notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening notification settings...'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    if (_selectedFilter == 'All') {
      return _notifications;
    }
    return _notifications.where((notification) {
      return notification['type'] == _selectedFilter;
    }).toList();
  }

  // Dummy notifications data
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Aadhaar Card Expiring Soon',
      'message': 'Your Aadhaar card will expire in 30 days. Renew it now to avoid any inconvenience.',
      'type': 'Expiry',
      'time': '2 hours ago',
      'isUnread': true,
      'icon': Icons.warning,
      'color': Colors.orange,
    },
    {
      'title': 'PAN Card Application Approved',
      'message': 'Congratulations! Your PAN card application has been approved. You will receive it within 7-10 days.',
      'type': 'Status',
      'time': '1 day ago',
      'isUnread': true,
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'title': 'Driving License Renewal Due',
      'message': 'Your driving license expires next month. Complete the renewal process to maintain validity.',
      'type': 'Expiry',
      'time': '2 days ago',
      'isUnread': false,
      'icon': Icons.directions_car,
      'color': Colors.red,
    },
    {
      'title': 'New Document Uploaded',
      'message': 'A new document has been uploaded to your DigiLocker. Check your document vault.',
      'type': 'Updates',
      'time': '3 days ago',
      'isUnread': false,
      'icon': Icons.upload_file,
      'color': Colors.blue,
    },
    {
      'title': 'Security Alert',
      'message': 'New login detected from a new device. If this wasn\'t you, please change your password immediately.',
      'type': 'Security',
      'time': '1 week ago',
      'isUnread': false,
      'icon': Icons.security,
      'color': Colors.red,
    },
    {
      'title': 'Passport Application Status',
      'message': 'Your passport application is under review. Expected completion time: 15-20 working days.',
      'type': 'Status',
      'time': '1 week ago',
      'isUnread': false,
      'icon': Icons.flight,
      'color': Colors.purple,
    },
    {
      'title': 'Voter ID Update Available',
      'message': 'You can now update your address in your Voter ID card. Click here to proceed.',
      'type': 'Updates',
      'time': '2 weeks ago',
      'isUnread': false,
      'icon': Icons.how_to_vote,
      'color': Colors.indigo,
    },
    {
      'title': 'Birth Certificate Verification',
      'message': 'Your birth certificate has been successfully verified and is now available in your document vault.',
      'type': 'Status',
      'time': '2 weeks ago',
      'isUnread': false,
      'icon': Icons.child_care,
      'color': Colors.teal,
    },
  ];
}
