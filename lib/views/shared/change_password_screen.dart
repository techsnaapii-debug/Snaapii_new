import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_api.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _old = TextEditingController();
  final _new = TextEditingController();
  final _confirm = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _old.dispose();
    _new.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_submitting) {
      return;
    }
    if (_old.text.isEmpty) {
      return _show('Enter your current password.');
    }
    if (_new.text.length < 8) {
      return _show('New password must be at least 8 characters.');
    }
    if (_new.text != _confirm.text) {
      return _show('Passwords do not match.');
    }
    setState(() => _submitting = true);
    try {
      await AuthApi.changePassword(
        oldPassword: _old.text,
        newPassword: _new.text,
      );
      if (!mounted) return;
      Get.back();
      Get.snackbar('Password changed', 'Your password has been updated.');
    } on ApiException catch (error) {
      if (mounted) _show(error.message);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _show(String message) => ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Change password')),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Use a new password with at least 8 characters.'),
            const SizedBox(height: 28),
            _field(_old, 'Current password'),
            const SizedBox(height: 16),
            _field(_new, 'New password'),
            const SizedBox(height: 16),
            _field(_confirm, 'Confirm new password'),
            const Spacer(),
            FilledButton(
              onPressed: _submitting ? null : _submit,
              child: Text(_submitting ? 'Saving…' : 'Change password'),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _field(TextEditingController controller, String label) => TextField(
    controller: controller,
    obscureText: true,
    textInputAction: TextInputAction.next,
    decoration: InputDecoration(
      labelText: label,
      border: const OutlineInputBorder(),
    ),
  );
}
