import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'influencer_screen.dart';

class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreen();
}

class _BasicDetailsScreen extends State<BasicDetailsScreen> {
  String _selectedLocationType = '';
  String _selectedCategory = 'Select Category';
  String _selectedDeadline = '';
  String _selectedState = '';
  String _selectedCity = '';
  final List<String> _statesList = const [
    'Assam',
    'Bihar',
    'Goa',
    'Gujarat',
    'Maharashtra',
    'Karnataka',
    'Rajasthan',
    'Uttar Pradesh',
  ];
  final List<String> _citiesList = const [
    'New Delhi',
    'Mumbai',
    'Bangalore',
    'Pune',
    'Kolkata',
    'Chennai',
    'Hyderabad',
    'Ahmedabad',
  ];
  DateTime _currentCalendarMonth = DateTime(2026, 4);
  final List<String> _monthsList = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SizedBox.expand(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 37),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xFF6B4EFF),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Basic Details',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF6B4EFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          const Text(
                            'Step 1 of 4',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              _buildStepCircle('1', isActive: true),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFF9E8EFE),
                                ),
                              ),
                              _buildStepCircle('2', isActive: false),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFFEBE8FC),
                                ),
                              ),
                              _buildStepCircle('3', isActive: false),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFFEBE8FC),
                                ),
                              ),
                              _buildStepCircle('4', isActive: false),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),

                              _buildLabel('Campaign Name'),
                              _buildInputField(hintText: 'Enter Name'),
                              const SizedBox(height: 24),

                              _buildLabel('Influencer Category'),
                              _buildDropdownField(
                                hintText: _selectedCategory,
                                isHintActive:
                                    _selectedCategory == 'Select Category',
                                onTap: _showCategoryDialog,
                              ),
                              const SizedBox(height: 24),

                              _buildLabel('Deadline'),
                              _buildDropdownField(
                                hintText: _selectedDeadline,
                                isHintActive: _selectedDeadline.isEmpty,
                                onTap: _showDeadlineDialog,
                              ),
                              const SizedBox(height: 28),

                              _buildLocationCard(),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                      child: CustomButton(
                        text: 'Next',
                        isGradient: true,
                        width: double.infinity,
                        onTap: () {
                          Get.to(() => const InfluencerScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(String step, {required bool isActive}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF9E8EFE) : const Color(0xFFEBE8FC),
      ),
      child: Center(
        child: Text(
          step,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildInputField({required String hintText}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      child: TextField(
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Color(0xFFC5C5C5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hintText,
    bool isHintActive = true,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: isHintActive ? FontWeight.w500 : FontWeight.w600,
                color: isHintActive ? const Color(0xFFC5C5C5) : Colors.black,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black87,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          alignment: Alignment.topCenter,
          insetPadding: const EdgeInsets.only(top: 180, left: 24, right: 24),
          backgroundColor: const Color(0xFFF2F2F7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Influencer Category',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF222222),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          Icons.cancel,
                          color: Color(0xFF8E8E93),
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(
                    color: Color(0xFFD1D1D6),
                    thickness: 1,
                    height: 1,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFE5E5EA),
                        width: 1.0,
                      ),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Icon(Icons.search, color: Color(0xFF8E8E93), size: 18),
                        SizedBox(width: 6),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Color(0xFFC5C5C5),
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDialogCategoryItem('Beauty'),
                  _buildDialogCategoryItem('Fashion'),
                  _buildDialogCategoryItem('Tech & Gadgets'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showStateDialog() {
    String query = '';
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            final filteredStates = _statesList
                .where((s) => s.toLowerCase().contains(query.toLowerCase()))
                .toList();

            return Dialog(
              alignment: Alignment.topCenter,
              insetPadding: const EdgeInsets.only(
                top: 180,
                left: 24,
                right: 24,
              ),
              backgroundColor: const Color(0xFFF2F2F7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select State',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF222222),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xFF8E8E93),
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(
                        color: Color(0xFFD1D1D6),
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFE5E5EA),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.search,
                              color: Color(0xFF8E8E93),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  dialogSetState(() {
                                    query = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search a particular State',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFFC5C5C5),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...filteredStates.map((state) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedState = state;
                              _selectedLocationType = 'state';
                            });
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 4,
                            ),
                            child: Text(
                              state,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCityDialog() {
    String query = '';
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            final filteredCities = _citiesList
                .where((c) => c.toLowerCase().contains(query.toLowerCase()))
                .toList();

            return Dialog(
              alignment: Alignment.topCenter,
              insetPadding: const EdgeInsets.only(
                top: 180,
                left: 24,
                right: 24,
              ),
              backgroundColor: const Color(0xFFF2F2F7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Select City',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF222222),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: const Icon(
                              Icons.cancel,
                              color: Color(0xFF8E8E93),
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(
                        color: Color(0xFFD1D1D6),
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFFE5E5EA),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            const Icon(
                              Icons.search,
                              color: Color(0xFF8E8E93),
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  dialogSetState(() {
                                    query = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search a particular City',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: Color(0xFFC5C5C5),
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...filteredCities.map((city) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCity = city;
                              _selectedLocationType = 'city';
                            });
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 4,
                            ),
                            child: Text(
                              city,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF333333),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDeadlineDialog() {
    FocusScope.of(context).unfocus();
    Future.delayed(const Duration(milliseconds: 150), () {
      if (!mounted) return;
      showDialog(
        context: context,
        barrierColor: Colors.black54,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, dialogSetState) {
              final DateTime month = _currentCalendarMonth;
              final DateTime firstDay = DateTime(month.year, month.month, 1);
              final int startOffset = firstDay.weekday % 7;
              final int daysInMonth = DateTime(
                month.year,
                month.month + 1,
                0,
              ).day;

              final List<String> calendarDays = [];
              for (int i = 0; i < startOffset; i++) {
                calendarDays.add('');
              }
              for (int i = 1; i <= daysInMonth; i++) {
                calendarDays.add(i.toString());
              }
              while (calendarDays.length % 7 != 0) {
                calendarDays.add('');
              }

              final List<TableRow> dateRows = [];
              for (int i = 0; i < calendarDays.length; i += 7) {
                final List<String> week = calendarDays.sublist(i, i + 7);
                dateRows.add(_buildCalendarRow(week));
              }

              return Dialog(
                alignment: Alignment.topCenter,
                insetPadding: const EdgeInsets.only(
                  top: 180,
                  left: 24,
                  right: 24,
                ),
                backgroundColor: const Color(0xFFF2F2F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 10.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Seleted date',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF222222),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.cancel,
                                color: Color(0xFF8E8E93),
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Divider(
                          color: Color(0xFFD1D1D6),
                          thickness: 1,
                          height: 1,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              '${_monthsList[month.month - 1]} ${month.year}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF222222),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                dialogSetState(() {
                                  _currentCalendarMonth = DateTime(
                                    _currentCalendarMonth.year,
                                    _currentCalendarMonth.month - 1,
                                  );
                                });
                              },
                              child: const Icon(
                                Icons.chevron_left,
                                color: Color(0xFF333333),
                                size: 26,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                dialogSetState(() {
                                  _currentCalendarMonth = DateTime(
                                    _currentCalendarMonth.year,
                                    _currentCalendarMonth.month + 1,
                                  );
                                });
                              },
                              child: const Icon(
                                Icons.chevron_right,
                                color: Color(0xFF333333),
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: const Color(0xFFE5E5EA),
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Table(
                                columnWidths: const {
                                  0: FractionColumnWidth(1 / 7),
                                  1: FractionColumnWidth(1 / 7),
                                  2: FractionColumnWidth(1 / 7),
                                  3: FractionColumnWidth(1 / 7),
                                  4: FractionColumnWidth(1 / 7),
                                  5: FractionColumnWidth(1 / 7),
                                  6: FractionColumnWidth(1 / 7),
                                },
                                children: [_buildCalendarHeaderRow()],
                              ),
                              const SizedBox(height: 1),
                              Table(
                                border: TableBorder.all(
                                  color: const Color(0xFF999999),
                                  width: 0.5,
                                ),
                                columnWidths: const {
                                  0: FractionColumnWidth(1 / 7),
                                  1: FractionColumnWidth(1 / 7),
                                  2: FractionColumnWidth(1 / 7),
                                  3: FractionColumnWidth(1 / 7),
                                  4: FractionColumnWidth(1 / 7),
                                  5: FractionColumnWidth(1 / 7),
                                  6: FractionColumnWidth(1 / 7),
                                },
                                children: dateRows,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      );
    });
  }

  TableRow _buildCalendarHeaderRow() {
    final headers = [
      'SUNDAY',
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
    ];
    return TableRow(
      children: headers
          .map(
            (h) => Container(
              padding: const EdgeInsets.only(top: 6, bottom: 2),
              alignment: Alignment.center,
              child: Text(
                h,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 6.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  TableRow _buildCalendarRow(List<String> days) {
    return TableRow(
      children: days.map((d) => _buildCalendarDayCell(d)).toList(),
    );
  }

  Widget _buildCalendarDayCell(String day) {
    if (day.isEmpty) {
      return const SizedBox(height: 32);
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDeadline =
              '$day ${_monthsList[_currentCalendarMonth.month - 1]} ${_currentCalendarMonth.year}';
        });
        Get.back();
      },
      child: Container(
        height: 32,
        padding: const EdgeInsets.all(2),
        alignment: Alignment.topLeft,
        color: Colors.transparent,
        child: Text(
          day,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDialogCategoryItem(String categoryName) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = categoryName;
        });
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Text(
          categoryName,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Creator's Location",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Choose your Creator's Location",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF8E8E93),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFEBE8FC), height: 1),
          const SizedBox(height: 16),
          _buildLocationOption('state'),
          const SizedBox(height: 16),
          _buildLocationOption('city'),
        ],
      ),
    );
  }

  Widget _buildLocationOption(String value) {
    final bool isSelected = _selectedLocationType == value;
    final String boldText = value == 'state'
        ? (_selectedState.isEmpty ? 'state' : 'state ($_selectedState)')
        : (_selectedCity.isEmpty ? 'City' : 'City ($_selectedCity)');

    return GestureDetector(
      onTap: () {
        if (value == 'state') {
          _showStateDialog();
        } else {
          _showCityDialog();
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Choose a particular ',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8E8E93),
                ),
                children: [
                  TextSpan(
                    text: boldText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF9E8EFE)
                    : const Color(0xFFC5C5C5),
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF9E8EFE),
                      ),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
