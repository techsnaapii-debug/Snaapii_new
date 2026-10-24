import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'autoreply_preview_automation_screen.dart';

class AutoreplyAutomationScreen extends StatefulWidget {
  const AutoreplyAutomationScreen({super.key});

  @override
  State<AutoreplyAutomationScreen> createState() =>
      _AutoreplyAutomationScreenState();
}

class _AutoreplyAutomationScreenState extends State<AutoreplyAutomationScreen> {
  final GlobalKey _dropdownKey = GlobalKey();
  bool _allPostReel = false;
  int _selectedPostIndex = 1;
  final TextEditingController _nameController = TextEditingController();

  bool _repliesPerReel = false;
  double _repliesCount = 100;
  final TextEditingController _repliesController = TextEditingController(
    text: '100',
  );
  String _selectedDelay = 'After 15 Seconds';
  bool _showReplyDelayInfo = false;
  bool _autoLikeComments = false;
  double _autoLikeCount = 100;
  final TextEditingController _autoLikeController = TextEditingController(
    text: '100',
  );

  final List<String> _delayOptions = [
    'After 15 Seconds',
    'After 10 Seconds',
    'After 5 Seconds',
    'Immediately',
  ];

  final List<Map<String, dynamic>> _posts = [
    {'isNext': true, 'title': 'Next Post\nor Reel', 'image': ''},
    {
      'isNext': false,
      'title': 'Post 1',
      'image': 'assets/images/girl_image.png',
    },
    {
      'isNext': false,
      'title': 'Post 2',
      'image': 'assets/images/animate_girl.png',
    },
    {'isNext': false, 'title': 'Post 3', 'image': 'assets/images/bancy.png'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _repliesController.dispose();
    _autoLikeController.dispose();
    super.dispose();
  }

  void _showDelayPickerPopup(BuildContext context) {
    final RenderBox? renderBox =
        _dropdownKey.currentContext?.findRenderObject() as RenderBox?;
    Offset offset = Offset.zero;
    Size boxSize = Size.zero;
    if (renderBox != null) {
      offset = renderBox.localToGlobal(Offset.zero);
      boxSize = renderBox.size;
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double popupTop = offset.dy > 0 ? (offset.dy + 12) : 380;
    final double popupRight = offset.dx > 0
        ? (screenWidth - offset.dx - boxSize.width + 12)
        : 20;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black.withValues(alpha: 0.15),
      transitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            Positioned(
              top: popupTop,
              right: popupRight,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 235,
                  padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFC4B5FD),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'When to send the Reply?',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            behavior: HitTestBehavior.opaque,
                            child: const Padding(
                              padding: EdgeInsets.all(2.0),
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                                size: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Divider(
                        color: Color(0xFFF3F4F6),
                        thickness: 1.2,
                        height: 1,
                      ),
                      const SizedBox(height: 10),

                      ..._delayOptions.map((option) {
                        final isSelected = _selectedDelay == option;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedDelay = option;
                            });
                            Navigator.pop(context);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.5),
                            child: Row(
                              children: [
                                Container(
                                  width: 18,
                                  height: 18,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? const Color(0xFFEDE9FE)
                                        : Colors.white,
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFFBA8FFF)
                                          : const Color(0xFF9CA3AF),
                                      width: 1.8,
                                    ),
                                  ),
                                  child: isSelected
                                      ? Center(
                                          child: Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFFBA8FFF),
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  option,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Get.back(),
                              behavior: HitTestBehavior.opaque,
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Color(0xFF6B4EFF),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Auto reply',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B4EFF),
                              ),
                            ),
                          ],
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
                  const SizedBox(height: 16),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Select a Post or Reel',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFC4B5FD),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'All Post/ Reel',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Transform.scale(
                                  scale: 0.8,
                                  child: Switch(
                                    value: _allPostReel,
                                    activeThumbColor: Colors.white,
                                    activeTrackColor: const Color(0xFF6B4EFF),
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: const Color(0xFFE0E0E0),
                                    thumbIcon:
                                        WidgetStateProperty.resolveWith<Icon?>((
                                          states,
                                        ) {
                                          if (!states.contains(
                                            WidgetState.selected,
                                          )) {
                                            return const Icon(
                                              Icons.close,
                                              color: Color(0xFF9E9E9E),
                                              size: 20,
                                            );
                                          }
                                          return const Icon(
                                            Icons.check,
                                            color: Color(0xFF6B4EFF),
                                            size: 20,
                                          );
                                        }),
                                    onChanged: (value) {
                                      setState(() {
                                        _allPostReel = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),

                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: List.generate(_posts.length, (index) {
                                final post = _posts[index];
                                final isSelected =
                                    _selectedPostIndex == index &&
                                    !_allPostReel;
                                final isNext = post['isNext'] == true;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedPostIndex = index;
                                      _allPostReel = false;
                                    });
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: 104,
                                    height: 135,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF6B4EFF)
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          if (isNext)
                                            Container(
                                              color: Colors.black,
                                              child: Center(
                                                child: Text(
                                                  post['title'],
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                    height: 1.3,
                                                  ),
                                                ),
                                              ),
                                            )
                                          else
                                            Image.asset(
                                              post['image'],
                                              fit: BoxFit.cover,
                                            ),

                                          Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: isSelected
                                                    ? const Color(0xFFBA8FFF)
                                                    : Colors.black.withValues(
                                                        alpha: 0.35,
                                                      ),
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : const Color(0xFFD1D5DB),
                                                  width: 2,
                                                ),
                                              ),
                                              child: isSelected
                                                  ? Center(
                                                      child: Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Name of Automation',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            height: 48,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFC4B5FD),
                                width: 1.2,
                              ),
                            ),
                            child: TextField(
                              controller: _nameController,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                hintText: 'Enter automation name',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                  color: Color(0xFFBDBDBD),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Advanced Setting',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 10),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _repliesPerReel = !_repliesPerReel;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: _repliesPerReel ? 12 : 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFC4B5FD),
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Replies Per Reel',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Switch(
                                          value: _repliesPerReel,
                                          activeThumbColor: Colors.white,
                                          activeTrackColor: const Color(
                                            0xFF6B4EFF,
                                          ),
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: const Color(
                                            0xFFE0E0E0,
                                          ),
                                          thumbIcon:
                                              WidgetStateProperty.resolveWith<
                                                Icon?
                                              >((states) {
                                                if (!states.contains(
                                                  WidgetState.selected,
                                                )) {
                                                  return const Icon(
                                                    Icons.close,
                                                    color: Color(0xFF9E9E9E),
                                                    size: 20,
                                                  );
                                                }
                                                return const Icon(
                                                  Icons.check,
                                                  color: Color(0xFF6B4EFF),
                                                  size: 20,
                                                );
                                              }),
                                          onChanged: (value) {
                                            setState(() {
                                              _repliesPerReel = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_repliesPerReel) ...[
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              trackHeight: 4,
                                              activeTrackColor: const Color(
                                                0xFFBA8FFF,
                                              ),
                                              inactiveTrackColor: const Color(
                                                0xFFE9D5FF,
                                              ),
                                              thumbColor: const Color(
                                                0xFF6B4EFF,
                                              ),
                                              overlayColor: const Color(
                                                0xFF6B4EFF,
                                              ).withValues(alpha: 0.12),
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                    enabledThumbRadius: 9,
                                                  ),
                                              overlayShape:
                                                  const RoundSliderOverlayShape(
                                                    overlayRadius: 16,
                                                  ),
                                            ),
                                            child: Slider(
                                              value: _repliesCount.clamp(
                                                100,
                                                100000,
                                              ),
                                              min: 100,
                                              max: 100000,
                                              onChanged: (val) {
                                                setState(() {
                                                  _repliesCount = val;
                                                  _repliesController.text =
                                                      '${val.toInt()}';
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 68,
                                          height: 38,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFAF5FF),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFC4B5FD),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Center(
                                            child: TextField(
                                              controller: _repliesController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                              onChanged: (value) {
                                                final typed = double.tryParse(
                                                  value,
                                                );
                                                if (typed != null) {
                                                  setState(() {
                                                    _repliesCount = typed.clamp(
                                                      100,
                                                      100000,
                                                    );
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFFC4B5FD),
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'Reply delay',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _showReplyDelayInfo =
                                              !_showReplyDelayInfo;
                                        });
                                      },
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFC4B5FD),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'i',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_showReplyDelayInfo) ...[
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Adds a small delay before sending replies so the automation feels more natural and human-like instead of instant bot replies',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF9E9E9E),
                                      height: 1.35,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 10),

                                GestureDetector(
                                  key: _dropdownKey,
                                  onTap: () => _showDelayPickerPopup(context),
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    width: double.infinity,
                                    height: 46,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: const Color(0xFFC4B5FD),
                                        width: 1.1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _selectedDelay,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 13.5,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                          size: 26,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _autoLikeComments = !_autoLikeComments;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: _autoLikeComments ? 12 : 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: const Color(0xFFC4B5FD),
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Auto Like Comments',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 0.8,
                                        child: Switch(
                                          value: _autoLikeComments,
                                          activeThumbColor: Colors.white,
                                          activeTrackColor: const Color(
                                            0xFF6B4EFF,
                                          ),
                                          inactiveThumbColor: Colors.white,
                                          inactiveTrackColor: const Color(
                                            0xFFE0E0E0,
                                          ),
                                          thumbIcon:
                                              WidgetStateProperty.resolveWith<
                                                Icon?
                                              >((states) {
                                                if (!states.contains(
                                                  WidgetState.selected,
                                                )) {
                                                  return const Icon(
                                                    Icons.close,
                                                    color: Color(0xFF9E9E9E),
                                                    size: 20,
                                                  );
                                                }
                                                return const Icon(
                                                  Icons.check,
                                                  color: Color(0xFF6B4EFF),
                                                  size: 20,
                                                );
                                              }),
                                          onChanged: (value) {
                                            setState(() {
                                              _autoLikeComments = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_autoLikeComments) ...[
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              trackHeight: 4,
                                              activeTrackColor: const Color(
                                                0xFFBA8FFF,
                                              ),
                                              inactiveTrackColor: const Color(
                                                0xFFE9D5FF,
                                              ),
                                              thumbColor: const Color(
                                                0xFF6B4EFF,
                                              ),
                                              overlayColor: const Color(
                                                0xFF6B4EFF,
                                              ).withValues(alpha: 0.12),
                                              thumbShape:
                                                  const RoundSliderThumbShape(
                                                    enabledThumbRadius: 9,
                                                  ),
                                              overlayShape:
                                                  const RoundSliderOverlayShape(
                                                    overlayRadius: 16,
                                                  ),
                                            ),
                                            child: Slider(
                                              value: _autoLikeCount.clamp(
                                                100,
                                                100000,
                                              ),
                                              min: 100,
                                              max: 100000,
                                              onChanged: (val) {
                                                setState(() {
                                                  _autoLikeCount = val;
                                                  _autoLikeController.text =
                                                      '${val.toInt()}';
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 68,
                                          height: 38,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFAF5FF),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            border: Border.all(
                                              color: const Color(0xFFC4B5FD),
                                              width: 1.2,
                                            ),
                                          ),
                                          child: Center(
                                            child: TextField(
                                              controller: _autoLikeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                              decoration: const InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,
                                              ),
                                              onChanged: (value) {
                                                final typed = double.tryParse(
                                                  value,
                                                );
                                                if (typed != null) {
                                                  setState(() {
                                                    _autoLikeCount = typed
                                                        .clamp(100, 100000);
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 20),
                    child: GestureDetector(
                        onTap: () {
                          final selectedPost = _posts.length > _selectedPostIndex
                              ? _posts[_selectedPostIndex]['image']
                              : null;
                          Get.to(
                            () => AutoreplyPreviewScreen(
                              postImage: selectedPost,
                              automationName: _nameController.text.trim(),
                              delay: _selectedDelay,
                              repliesCount: _repliesPerReel
                                  ? _repliesCount.toInt()
                                  : null,
                              autoLikeCount: _autoLikeComments
                                  ? _autoLikeCount.toInt()
                                  : null,
                            ),
                          );
                        },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(
                                0xFF6B4EFF,
                              ).withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Live & Preview',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
