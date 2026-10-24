import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:snaapii/widgets/creator_widget/creator_bottom_nav_bar.dart';
import 'package:snaapii/widgets/creator_widget/creator_chat_item.dart';

class CreatorChatScreen extends StatefulWidget {
  const CreatorChatScreen({super.key});

  @override
  State<CreatorChatScreen> createState() => _CreatorChatScreenState();
}

class _CreatorChatScreenState extends State<CreatorChatScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Active', 'Unread', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 6.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Chat',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6B4EFF),
                                ),
                              ),
                              Container(
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 2),
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        SizedBox(
                          height: 40,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: _filters.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(width: 10),
                            itemBuilder: (context, index) {
                              final filter = _filters[index];
                              final bool isSelected = _selectedFilter == filter;
                              return GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedFilter = filter),
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 22,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF8655FE)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    border: isSelected
                                        ? null
                                        : Border.all(
                                            color: const Color(0xFFD6C8FF),
                                            width: 1.5,
                                          ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      filter,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF1E1A34),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 20),

                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            physics: const BouncingScrollPhysics(),
                            children: [
                              CreatorChatItem(
                                avatarWidget: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF4A0010),
                                    shape: BoxShape.circle,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'GUCCI',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ),
                                title: 'Gucci',
                                subtitle: 'Brand is offering: ₹10,000',
                                time: '10:00 PM',
                                unreadCount: 1,
                              ),
                              const Divider(
                                color: Color(0xFFE9DDFE),
                                height: 1,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 90),
                      ],
                    ),
                  ),

                  const CreatorBottomNavBar(selectedTabIndex: 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

