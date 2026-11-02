import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../services/auth_api.dart';
import '../../services/profile_api.dart';
import '../../widgets/custom_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  Map<String, dynamic> _original = {};
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _genders = [];
  int? _categoryId;
  int? _genderId;
  bool _isLoading = true;
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([
        ProfileApi.creatorProfile(),
        ProfileApi.categories(),
        ProfileApi.genders(),
      ]);
      if (!mounted) return;
      final profile = results[0] as Map<String, dynamic>;
      setState(() {
        _original = profile;
        _categories = results[1] as List<Map<String, dynamic>>;
        _genders = results[2] as List<Map<String, dynamic>>;
        _categoryId = int.tryParse(profile['category_id']?.toString() ?? '');
        _genderId = int.tryParse(profile['gender_id']?.toString() ?? '');
        _nameController.text = profile['name']?.toString() ?? '';
        _bioController.text = profile['bio']?.toString() ?? '';
        _stateController.text = profile['state']?.toString() ?? '';
        _cityController.text = profile['city']?.toString() ?? '';
        final date = profile['date_of_birth']?.toString() ?? '';
        _dobController.text = date.length >= 10 ? date.substring(0, 10) : date;
        _phoneController.text = profile['phone_number']?.toString() ?? '';
        _emailController.text = profile['email']?.toString() ?? '';
        _isLoading = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() {
          _error = error.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _save() async {
    if (_isSaving || _isLoading || _error != null) return;
    final date = _dobController.text.trim();
    if (date.isNotEmpty &&
        (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(date) ||
            DateTime.tryParse(date) == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Date of birth must be YYYY-MM-DD.')),
      );
      return;
    }
    setState(() => _isSaving = true);
    try {
      await ProfileApi.updateBasic(
        expectedRole: 2,
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
      );
      await ProfileApi.updateCreator(
        original: _original,
        bio: _bioController.text,
        state: _stateController.text,
        city: _cityController.text,
        dateOfBirth: date,
        categoryId: _categoryId,
        genderId: _genderId,
      );
      if (mounted) Get.back(result: true);
    } on ApiException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error.message)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not update profile. Please try again.'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
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
                          _buildChoiceField(
                            'Category',
                            _categories,
                            _categoryId,
                            (id) => setState(() => _categoryId = id),
                            'category_name',
                          ),
                          _buildChoiceField(
                            'Gender',
                            _genders,
                            _genderId,
                            (id) => setState(() => _genderId = id),
                            'name',
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
                            'Email',
                            controller: _emailController,
                          ),

                          if (_isLoading)
                            const Center(child: CircularProgressIndicator()),
                          if (_error != null)
                            Text(
                              _error!,
                              style: const TextStyle(color: Colors.red),
                            ),

                          const SizedBox(height: 24),

                          CustomButton(
                            text: _isSaving ? 'Saving...' : 'Save',
                            isGradient: true,
                            width: double.infinity,
                            height: 52,
                            borderRadius: 30,
                            textColor: Colors.white,
                            gradientColors: const [
                              Color(0xFFB18CFF),
                              Color(0xFF565EFA),
                            ],
                            onTap: _save,
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

  Widget _buildChoiceField(
    String label,
    List<Map<String, dynamic>> options,
    int? selectedId,
    ValueChanged<int?> onChanged,
    String nameField,
  ) {
    final choices = options
        .where((item) => int.tryParse(item['id']?.toString() ?? '') != null)
        .toList();
    final hasSelected = choices.any(
      (item) => int.tryParse(item['id'].toString()) == selectedId,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<int>(
          initialValue: hasSelected ? selectedId : null,
          hint: Text(
            choices.isEmpty ? 'No options available' : 'Select $label',
          ),
          items: choices
              .map(
                (item) => DropdownMenuItem<int>(
                  value: int.parse(item['id'].toString()),
                  child: Text(item[nameField]?.toString() ?? ''),
                ),
              )
              .toList(),
          onChanged: choices.isEmpty ? null : onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
