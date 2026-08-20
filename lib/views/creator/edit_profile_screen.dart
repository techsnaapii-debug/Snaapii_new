import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Richa',
  );
  final TextEditingController _bioController = TextEditingController(
    text: 'I’m a Content Creator',
  );
  final TextEditingController _categoryController = TextEditingController(
    text: 'Beauty',
  );
  final TextEditingController _genderController = TextEditingController(
    text: 'Female',
  );
  final TextEditingController _stateController = TextEditingController(
    text: 'Delhi',
  );
  final TextEditingController _cityController = TextEditingController(
    text: 'New delhi',
  );
  final TextEditingController _dobController = TextEditingController(
    text: '23-04-2006',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '9997776665',
  );
  final TextEditingController _addressController = TextEditingController(
    text: 'richaa09@gmail.com',
  );

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _categoryController.dispose();
    _genderController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Column(
                children: [
                  const SizedBox(height: 37),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFF6B4EFF),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Edit Profile',
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

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),

                          Center(
                            child: Container(
                              width: 104,
                              height: 104,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF9E8EFE),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/user_avatar.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                        color: const Color(0xFF9E8EFE),
                                        child: const Icon(
                                          Icons.person,
                                          size: 50,
                                          color: Colors.white,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          _buildInputField('Name', controller: _nameController),
                          _buildInputField('Bio', controller: _bioController),
                          _buildInputField(
                            'Category',
                            controller: _categoryController,
                          ),
                          _buildInputField(
                            'Gender',
                            controller: _genderController,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: _buildInputField(
                                  'State',
                                  controller: _stateController,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildInputField(
                                  'City',
                                  controller: _cityController,
                                ),
                              ),
                            ],
                          ),

                          _buildInputField(
                            'Date of Birth',
                            controller: _dobController,
                          ),
                          _buildInputField(
                            'Phone Number',
                            controller: _phoneController,
                          ),
                          _buildInputField(
                            'Address Details',
                            controller: _addressController,
                          ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: 'Save',
                            isGradient: true,
                            width: double.infinity,
                            height: 52,
                            borderRadius: 30,
                            textColor: Colors.white,
                            gradientColors: const [
                              Color(0xFFB18CFF),
                              Color(0xFF565EFA),
                            ],
                            onTap: () {
                              Get.back();
                            },
                          ),

                          const SizedBox(height: 36),
                        ],
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

  Widget _buildInputField(
    String label, {
    TextEditingController? controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF4A4A4A),
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFFE5E5E5),
                width: 1.2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF9E8EFE),
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
