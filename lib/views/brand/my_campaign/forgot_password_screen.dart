import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/auth_api.dart';
import '../../../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _email = TextEditingController();
  final _otp = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  int _step = 0;
  String? _userId;
  String? _resetToken;
  bool _submitting = false;

  @override
  void dispose() {
    _email.dispose();
    _otp.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    if (_submitting) return;
    setState(() => _submitting = true);
    try {
      if (_step == 0) {
        final email = _email.text.trim();
        if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email)) {
          throw const ApiException('Enter a valid email address.');
        }
        _userId = await AuthApi.requestPasswordReset(email);
        if (!mounted) return;
        setState(() => _step = 1);
      } else if (_step == 1) {
        if (_otp.text.trim().isEmpty) {
          throw const ApiException('Enter the OTP you received.');
        }
        _resetToken = await AuthApi.verifyPasswordResetOtp(
          userId: _userId!,
          otp: _otp.text,
        );
        if (!mounted) return;
        setState(() => _step = 2);
      } else {
        if (_password.text.length < 8) {
          throw const ApiException('Password must be at least 8 characters.');
        }
        if (_password.text != _confirmPassword.text) {
          throw const ApiException('Passwords do not match.');
        }
        await AuthApi.resetPassword(
          resetToken: _resetToken!,
          password: _password.text,
        );
        if (!mounted) return;
        Get.back();
        Get.snackbar(
          'Password updated',
          'You can now log in with your new password.',
        );
      }
    } on ApiException catch (error) {
      if (mounted) _showMessage(error.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _showMessage(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    final title = [
      'Reset password',
      'Verify OTP',
      'Choose a new password',
    ][_step];
    final subtitle = [
      'Enter the email address for your account.',
      'Enter the one-time password sent to your email.',
      'Use a strong password you have not used before.',
    ][_step];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 36),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Color(0xFF666666)),
                  ),
                  const SizedBox(height: 28),
                  if (_step == 0)
                    _field(_email, 'Email address', TextInputType.emailAddress)
                  else if (_step == 1)
                    _field(_otp, 'OTP', TextInputType.number)
                  else ...[
                    _field(
                      _password,
                      'New password',
                      TextInputType.visiblePassword,
                      obscure: true,
                    ),
                    const SizedBox(height: 16),
                    _field(
                      _confirmPassword,
                      'Confirm new password',
                      TextInputType.visiblePassword,
                      obscure: true,
                    ),
                  ],
                  const Spacer(),
                  CustomButton(
                    text: _submitting
                        ? 'Please wait…'
                        : _step == 2
                        ? 'Reset password'
                        : 'Continue',
                    width: double.infinity,
                    isGradient: true,
                    onTap: _continue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    TextInputType keyboardType, {
    bool obscure = false,
  }) => TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscure,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}
