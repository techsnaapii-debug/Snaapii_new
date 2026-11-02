import 'package:flutter/material.dart';

class MakeOfferDialog extends StatefulWidget {
  final bool isBrandView;
  final Function(String amount, String? message) onSendOffer;

  const MakeOfferDialog({
    super.key,
    required this.isBrandView,
    required this.onSendOffer,
  });

  @override
  State<MakeOfferDialog> createState() => _MakeOfferDialogState();
}

class _MakeOfferDialogState extends State<MakeOfferDialog> {
  late final TextEditingController _amountController;
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: widget.isBrandView ? '₹11000' : '₹ 12000',
    );
    _messageController = TextEditingController(
      text: widget.isBrandView
          ? ''
          : 'According to the profile , I was expecting more.',
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFFF0EBFF),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 24.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.isBrandView ? 'Counter Offer' : 'Infuencer Offer',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Color(0xFFDDD2FE), height: 1, thickness: 1),
            const SizedBox(height: 14),

            const Text(
              'Your Offer Amount',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1A34),
              ),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFA78BFA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: TextField(
                controller: _amountController,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            if (!widget.isBrandView) ...[
              const SizedBox(height: 14),
              const Text(
                'Message',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFA78BFA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: 3,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.35,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 20),

            Center(
              child: GestureDetector(
                onTap: () {
                  final amount = _amountController.text.trim();
                  final msg = _messageController.text.trim();
                  if (amount.isNotEmpty) {
                    widget.onSendOffer(amount, widget.isBrandView ? null : msg);
                  }
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA78BFA),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: const Text(
                    'Send Offer',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
