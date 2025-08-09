import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../utils/responsive_utils.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _selectedFilter = 'All'; // This will be updated dynamically

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    // Refresh notifications when language changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_notifications.isNotEmpty && 
          _notifications[0]['title'] != themeProvider.getText('notification_item_title')) {
        _refreshNotifications();
      }
    });
    
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
          themeProvider.getText('notifications'),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      padding: ResponsiveUtils.getResponsivePadding(context),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            themeProvider.getText('filter_notifications'),
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
                _buildFilterChip(themeProvider.getText('all'), Icons.all_inclusive),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip(themeProvider.getText('expiry'), Icons.warning),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip(themeProvider.getText('status'), Icons.track_changes),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip(themeProvider.getText('updates'), Icons.update),
                SizedBox(width: ResponsiveUtils.getPlatformAdjustedSpacing(context, 8)),
                _buildFilterChip(themeProvider.getText('security'), Icons.security),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
            themeProvider.getText('no_notifications'),
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
            themeProvider.getText('no_notifications_desc'),
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
    final themeProvider = Provider.of<ThemeProvider>(context);
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
              title: themeProvider.getText('mark_all_as_read'),
              onTap: () {
                Navigator.pop(context);
                _markAllAsRead();
              },
            ),
            _buildOptionItem(
              icon: Icons.delete_sweep,
              title: themeProvider.getText('clear_all_notifications'),
              onTap: () {
                Navigator.pop(context);
                _clearAllNotifications();
              },
            ),
            _buildOptionItem(
              icon: Icons.settings,
              title: themeProvider.getText('notification_settings'),
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
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      for (var notification in _notifications) {
        notification['isUnread'] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(themeProvider.getText('all_notifications_marked_read')),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _clearAllNotifications() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      _notifications.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(themeProvider.getText('all_notifications_cleared')),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _openNotificationSettings() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    // TODO: Navigate to notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(themeProvider.getText('opening_notification_settings')),
        backgroundColor: Colors.blue,
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredNotifications() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (_selectedFilter == themeProvider.getText('all')) {
      return _notifications;
    }
    return _notifications.where((notification) {
      return notification['type'] == _selectedFilter;
    }).toList();
  }

  // Dummy notifications data - will be populated with translated strings
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _notifications = [
      {
        'title': themeProvider.getText('notification_item_title'),
        'message': themeProvider.getText('notification_item_desc'),
        'type': themeProvider.getText('expiry'),
        'time': themeProvider.getText('notification_time'),
        'isUnread': true,
        'icon': Icons.warning,
        'color': Colors.orange,
      },
      {
        'title': themeProvider.getText('notification_item_title2'),
        'message': themeProvider.getText('notification_item_desc2'),
        'type': themeProvider.getText('status'),
        'time': themeProvider.getText('notification_time2'),
        'isUnread': true,
        'icon': Icons.check_circle,
        'color': Colors.green,
      },
      {
        'title': themeProvider.getText('notification_item_title3'),
        'message': themeProvider.getText('notification_item_desc3'),
        'type': themeProvider.getText('security'),
        'time': themeProvider.getText('notification_time3'),
        'isUnread': false,
        'icon': Icons.security,
        'color': Colors.red,
      },
    ];
  }

  void _refreshNotifications() {
    setState(() {
      _initializeNotifications();
    });
  }
}
