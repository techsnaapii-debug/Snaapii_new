import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../views/creator/campaign_details_screen.dart';

class ExploreCardItem extends StatelessWidget {
  final Map<String, String> cardData;

  const ExploreCardItem({
    super.key,
    required this.cardData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => CampaignDetailsScreen(
            brandName: cardData['brand'],
            category: cardData['category'],
            imagePath: cardData['image'],
            followers: cardData['followers'],
            reel: cardData['reel'],
            story: cardData['story'],
            post: cardData['post'],
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF9E8EFE).withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  cardData['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFFDCD6CD),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white54,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                      () => CampaignDetailsScreen(
                        brandName: cardData['brand'],
                        category: cardData['category'],
                        imagePath: cardData['image'],
                        followers: cardData['followers'],
                        reel: cardData['reel'],
                        story: cardData['story'],
                        post: cardData['post'],
                      ),
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Read more',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                        Colors.black.withValues(alpha: 0.95),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text(
                            cardData['brand']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Category : ${cardData['category']!}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.person,
                            size: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            cardData['followers']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.movie_outlined,
                            size: 17,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cardData['reel']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.play_circle_outline,
                            size: 17,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cardData['story']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/instagram_icon.png',
                            width: 17,
                            height: 17,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            cardData['post']!,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13.5,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
