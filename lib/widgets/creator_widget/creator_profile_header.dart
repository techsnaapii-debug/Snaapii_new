import 'package:flutter/material.dart';

class CreatorProfileHeader extends StatelessWidget {
  final String name;
  final String category;
  final String location;
  final String avatarPath;

  const CreatorProfileHeader({
    super.key,
    this.name = 'Richa',
    this.category = 'Beauty',
    this.location = 'New Delhi, Delhi',
    this.avatarPath = 'assets/images/user_avatar.png',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            avatarPath,
            width: 92,
            height: 92,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 92,
              height: 92,
              color: const Color(0xFF9E8EFE),
              child: const Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$name ',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '($category)',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF616161),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF9E8EFE),
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    location,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B4EFF),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
