import 'package:flutter/material.dart';

class SubmitFinalLinkDialog extends StatefulWidget {
  final ValueChanged<List<String>> onSubmit;

  const SubmitFinalLinkDialog({
    super.key,
    required this.onSubmit,
  });

  @override
  State<SubmitFinalLinkDialog> createState() => _SubmitFinalLinkDialogState();
}

class _SubmitFinalLinkDialogState extends State<SubmitFinalLinkDialog> {
  final List<TextEditingController> _linkControllers = [
    TextEditingController(),
  ];

  @override
  void dispose() {
    for (var controller in _linkControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: const Color(0xFFF0EBFF),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Submit Final Link',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Enter the final content links finish your campaigan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 20),

              for (int i = 0; i < _linkControllers.length; i++) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1.0,
                    ),
                  ),
                  child: TextField(
                    controller: _linkControllers[i],
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF1E1A34),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter Url Link',
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Color(0xFF9CA3AF),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              GestureDetector(
                onTap: () {
                  setState(() {
                    _linkControllers.add(TextEditingController());
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2D6FF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFB18CFF),
                      width: 1.2,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, size: 20, color: Color(0xFF1E1A34)),
                      SizedBox(width: 6),
                      Text(
                        'Add another link',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E1A34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFFD1D5DB),
                          width: 1.2,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E1A34),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () {
                      final List<String> validLinks = _linkControllers
                          .map((c) => c.text.trim())
                          .where((t) => t.isNotEmpty)
                          .toList();
                      if (validLinks.isNotEmpty) {
                        widget.onSubmit(validLinks);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA78BFA),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
