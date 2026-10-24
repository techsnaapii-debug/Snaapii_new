import 'package:flutter/material.dart';

class NotificationModel {
  final String id;
  final String title;
  final String description;
  final String time;
  final String category; // 'campaign', 'payment', 'update', etc.
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final bool isUnread;
  final String dateSection; // 'Today', 'Yesterday', etc.

  const NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.category,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.isUnread = true,
    required this.dateSection,
  });
}

class NotificationScreen extends StatefulWidget {
  final List<NotificationModel>? initialNotifications;

  const NotificationScreen({super.key, this.initialNotifications});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedFilterIndex = 0;
  List<NotificationModel> _notifications = [];

  final List<String> _filters = [
    'All',
    'Unread',
    'Campaign',
    'Payment',
    'Update',
  ];

  @override
  void initState() {
    super.initState();
    // Default is empty to display the exact empty state from the first image
    _notifications = widget.initialNotifications != null
        ? List.from(widget.initialNotifications!)
        : [];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  int _getCountForFilter(String filter) {
    if (filter == 'All') {
      return _notifications.length;
    } else if (filter == 'Unread') {
      return _notifications.where((n) => n.isUnread).length;
    } else {
      return _notifications
          .where((n) => n.category.toLowerCase() == filter.toLowerCase())
          .length;
    }
  }

  List<NotificationModel> get _filteredNotifications {
    final query = _searchController.text.trim().toLowerCase();
    final filter = _filters[_selectedFilterIndex];

    return _notifications.where((n) {
      final matchesFilter = () {
        if (filter == 'All') return true;
        if (filter == 'Unread') return n.isUnread;
        return n.category.toLowerCase() == filter.toLowerCase();
      }();

      final matchesQuery =
          query.isEmpty ||
          n.title.toLowerCase().contains(query) ||
          n.description.toLowerCase().contains(query);

      return matchesFilter && matchesQuery;
    }).toList();
  }

  void _markAllAsRead() {
    if (_notifications.isEmpty) return;
    setState(() {
      _notifications = _notifications.map((n) {
        return NotificationModel(
          id: n.id,
          title: n.title,
          description: n.description,
          time: n.time,
          category: n.category,
          icon: n.icon,
          iconColor: n.iconColor,
          iconBgColor: n.iconBgColor,
          isUnread: false,
          dateSection: n.dateSection,
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredNotifications;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 20,
            color: Color(0xFF1E293B),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F5FA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.5,
                      color: Color(0xFF94A3B8),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      color: Color(0xFF64748B),
                      size: 22,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),

            // Filter Tabs
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: _filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = index == _selectedFilterIndex;
                  final count = _getCountForFilter(filter);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF384CF0)
                            : const Color(0xFFF3F5FA),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filter,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF2639DB)
                                  : const Color(0xFFE2E8F0),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // Mark all as read
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: _markAllAsRead,
                  child: const Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF384CF0),
                    ),
                  ),
                ),
              ),
            ),

            // Body: Empty State (First image) or List (Second image)
            Expanded(
              child: filteredList.isEmpty
                  ? _buildEmptyState()
                  : _buildNotificationList(filteredList),
            ),
          ],
        ),
      ),
    );
  }

  // First image: Empty state
  Widget _buildEmptyState() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/no_notifications.png',
              width: 220,
              height: 220,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Fallback illustration
                return Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F5FA),
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.notifications_off_outlined,
                      size: 80,
                      color: Color(0xFF384CF0),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 22),
            const Text(
              'No Notifications Yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "You'll see all important updates here,\nlike campaigns, messages, payments\nand more.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Second image: Notification list grouped by date section
  Widget _buildNotificationList(List<NotificationModel> list) {
    final Map<String, List<NotificationModel>> grouped = {};
    for (final item in list) {
      grouped.putIfAbsent(item.dateSection, () => []).add(item);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      itemCount: grouped.length,
      itemBuilder: (context, index) {
        final sectionKey = grouped.keys.elementAt(index);
        final items = grouped[sectionKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 8),
              child: Text(
                sectionKey,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
            ),
            ...items.map((item) => _buildNotificationCard(item)),
          ],
        );
      },
    );
  }

  Widget _buildNotificationCard(NotificationModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Icon Container
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: item.iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(item.icon, color: item.iconColor, size: 22),
            ),
          ),
          const SizedBox(width: 12),

          // Title & Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),

          // Time & Blue unread dot
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 6),
              if (item.isUnread)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF384CF0),
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(height: 8),
            ],
          ),
        ],
      ),
    );
  }
}
