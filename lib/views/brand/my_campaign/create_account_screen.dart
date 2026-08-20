import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  final bool isCreator;
  const CreateAccountScreen({super.key, this.isCreator = false});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _isPasswordObscured = true;
  bool _isAgreed = false;
  String _selectedCountryCode = '+91';
  final List<String> _countryCodes = [
    '+1',
    '+91',
    '+44',
    '+61',
    '+971',
    '+81',
    '+49',
    '+33',
    '+65',
    '+86',
    '+7',
    '+55',
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SizedBox.expand(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      'assets/images/onboard_bg.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  SafeArea(
                    top: true,
                    bottom: false,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 80),

                            Text(
                              'Create Account',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 36),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _buildLabel('Name'),
                                  const SizedBox(height: 8),
                                  _buildTextField(hintText: 'John Doe'),

                                  const SizedBox(height: 20),

                                  _buildLabel('Phone Number'),
                                  const SizedBox(height: 8),
                                  _buildPhoneField(),

                                  const SizedBox(height: 20),

                                  _buildLabel('Email'),
                                  const SizedBox(height: 8),
                                  _buildTextField(
                                    hintText: 'Doe12@gmail.com',
                                    keyboardType: TextInputType.emailAddress,
                                  ),

                                  const SizedBox(height: 20),

                                  _buildLabel('Password'),
                                  const SizedBox(height: 8),
                                  _buildPasswordField(),

                                  const SizedBox(height: 16),

                                  _buildAgreeTermsRow(),
                                ],
                              ),
                            ),

                            const SizedBox(height: 32),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32.0,
                              ),
                              child: _buildSignUpButton(),
                            ),

                            const SizedBox(height: 24),

                            _buildLoginRow(),

                            const SizedBox(height: 24),

                            _buildGoogleButton(),

                            const SizedBox(height: 32),
                          ],
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF666666),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      width: 287,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      child: TextField(
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xFFCCCCCC),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      height: 48,
      width: 287,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountryCode,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.black,
                  size: 20,
                ),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedCountryCode = newValue;
                    });
                  }
                },
                items: _countryCodes.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Container(width: 1.5, height: 24, color: const Color(0xFFEBE8FC)),
          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Enter Phone Number',
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  color: Color(0xFFCCCCCC),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      height: 48,
      width: 287,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      child: TextField(
        obscureText: _isPasswordObscured,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: '********',
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            color: Color(0xFFCCCCCC),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _isPasswordObscured = !_isPasswordObscured;
              });
            },
            child: Icon(
              _isPasswordObscured
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: const Color(0xFF666666),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAgreeTermsRow() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isAgreed = !_isAgreed;
            });
          },
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: _isAgreed ? Image.asset("assets/images/checkbox.png") : null,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          'Agree with ',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Term & Condition',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B4EFF),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return CustomButton(
      text: 'Sign Up',
      width: 263.0,
      backgroundColor: const Color(0xFFF9F8FF),
      textColor: const Color(0xFF000000),
      onTap: () {},
    );
  }

  Widget _buildLoginRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account ? ',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => LoginScreen(isCreator: widget.isCreator));
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            'Login',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF565EFA),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return Center(
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(.0),
            child: Image.asset(
              'assets/images/google.png',
              width: 36,
              height: 36,
            ),
          ),
        ),
      ),
    );
  }
}
