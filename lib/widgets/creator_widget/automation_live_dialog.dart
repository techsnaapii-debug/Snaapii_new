import 'package:flutter/material.dart';

class AutomationLiveDialog extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onOkay;

  const AutomationLiveDialog({
    super.key,
    this.title = 'Automation is Live!',
    this.description =
        'Your automation is now active and ready to respond automatically.',
    this.buttonText = 'Okay',
    required this.onOkay,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Automation is Live!',
    String description =
        'Your automation is now active and ready to respond automatically.',
    String buttonText = 'Okay',
    required VoidCallback onOkay,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      barrierDismissible: false,
      builder: (dialogContext) => AutomationLiveDialog(
        title: title,
        description: description,
        buttonText: buttonText,
        onOkay: onOkay,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 32, 22, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circular Checkmark Icon
            Container(
              width: 86,
              height: 86,
              decoration: const BoxDecoration(
                color: Color(0xFFD6F8DE),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: Color(0xFF34C759),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1A34),
                  height: 1.35,
                ),
              ),
            ),
            const SizedBox(height: 26),

            // Okay Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: onOkay,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF9E77ED), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  backgroundColor: Colors.white,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
