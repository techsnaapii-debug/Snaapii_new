import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import 'package:snaapii/widgets/creator_widget/creator_input_field.dart';

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

                          CreatorInputField(
                            label: 'Name',
                            controller: _nameController,
                          ),
                          CreatorInputField(
                            label: 'Bio',
                            controller: _bioController,
                          ),
                          CreatorInputField(
                            label: 'Category',
                            controller: _categoryController,
                          ),
                          CreatorInputField(
                            label: 'Gender',
                            controller: _genderController,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: CreatorInputField(
                                  label: 'State',
                                  controller: _stateController,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: CreatorInputField(
                                  label: 'City',
                                  controller: _cityController,
                                ),
                              ),
                            ],
                          ),

                          CreatorInputField(
                            label: 'Date of Birth',
                            controller: _dobController,
                          ),
                          CreatorInputField(
                            label: 'Phone Number',
                            controller: _phoneController,
                          ),
                          CreatorInputField(
                            label: 'Address Details',
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


}
