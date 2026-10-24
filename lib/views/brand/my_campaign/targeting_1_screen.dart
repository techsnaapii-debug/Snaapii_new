import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'campaign_media_screen.dart';

class Targeting1Screen extends StatefulWidget {
  const Targeting1Screen({super.key});

  @override
  State<Targeting1Screen> createState() => _Targeting1ScreenState();
}

class _Targeting1ScreenState extends State<Targeting1Screen> {
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _selectedGenders = [];
  String? _selectedAge;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
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
                                  'Targeting',
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
                            'Step 3 of 4',
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
                              _buildStepCircle('2', isActive: true),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFF9E8EFE),
                                ),
                              ),
                              _buildStepCircle('3', isActive: true),
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

                              _buildLabel('Campaign Description'),
                              _buildDescriptionField(
                                controller: _descriptionController,
                                hintText: 'Enter your description',
                              ),
                              const SizedBox(height: 24),

                              _buildLabel('Gender'),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildRadioOption(
                                      'Male',
                                      isGender: true,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildRadioOption(
                                      'Female',
                                      isGender: true,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildRadioOption(
                                      'Other',
                                      isGender: true,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              _buildLabel('Age'),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildRadioOption(
                                      '18 - 25',
                                      isGender: false,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildRadioOption(
                                      '25 - 35',
                                      isGender: false,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _buildRadioOption(
                                      'Above 35',
                                      isGender: false,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),

                              Row(
                                children: [
                                  Expanded(
                                    child: _buildDropdownField(type: 'Do\'s'),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: _buildDropdownField(type: 'Dont\'s'),
                                  ),
                                ],
                              ),
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
                          FocusScope.of(context).unfocus();
                          Get.to(() => const Targeting2Screen());
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildDescriptionField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
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
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, {required bool isGender}) {
    final bool isSelected = isGender
        ? _selectedGenders.contains(label)
        : (_selectedAge == label);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          if (isGender) {
            if (_selectedGenders.contains(label)) {
              _selectedGenders.remove(label);
            } else {
              _selectedGenders.add(label);
            }
          } else {
            _selectedAge = label;
          }
        });
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF9E8EFE)
                : const Color(0xFFD6C8FF),
            width: 1.5,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.black : const Color(0xFF8E8E93),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF9E8EFE)
                      : const Color(0xFFD6C8FF),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
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
      ),
    );
  }

  Widget _buildDropdownField({required String type}) {
    return Container(
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
            type,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFFC5C5C5),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black87,
            size: 24,
          ),
        ],
      ),
    );
  }
}
