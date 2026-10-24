import 'package:flutter/material.dart';

class WithdrawHistoryTile extends StatelessWidget {
  final Map<String, dynamic> item;

  const WithdrawHistoryTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSuccess = item['isSuccess'] ?? false;
    final bool isBank = item['isBank'] ?? false;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3EFFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: isBank
                  ? const Icon(
                      Icons.account_balance_outlined,
                      color: Color(0xFF6B4EFF),
                      size: 22,
                    )
                  : const Text(
                      'UPI',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6B4EFF),
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'] ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['date'] ?? '',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['amount'] ?? '',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isSuccess
                      ? const Color(0xFFE8F5E9)
                      : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isSuccess
                          ? Icons.check_circle_outline
                          : Icons.access_time,
                      size: 13,
                      color: isSuccess
                          ? const Color(0xFF2E7D32)
                          : const Color(0xFFEF6C00),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      item['status'] ?? '',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSuccess
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFEF6C00),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
