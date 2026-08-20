import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import 'targeting_1_screen.dart';

class InfluencerScreen extends StatefulWidget {
  const InfluencerScreen({super.key});

  @override
  State<InfluencerScreen> createState() => _InfluencerScreenState();
}

class _InfluencerScreenState extends State<InfluencerScreen> {
  final TextEditingController _minFollowersController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  int _numberOfInfluencers = 1;
  int _reelsCount = 1;
  int _storyCount = 1;
  int _postCount = 1;

  @override
  void dispose() {
    _minFollowersController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  int get _totalBudget {
    final int budgetPerInfluencer = int.tryParse(_budgetController.text) ?? 0;
    return _numberOfInfluencers * budgetPerInfluencer;
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
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SizedBox.expand(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 37),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Color(0xFF6B4EFF),
                                    size: 22,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Influencer',
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
                          const SizedBox(height: 20),

                          const Text(
                            'Step 2 of 4',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8E8E93),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              _buildStepCircle('1', isActive: true),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFF9E8EFE),
                                ),
                              ),
                              _buildStepCircle('2', isActive: true),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFF9E8EFE),
                                ),
                              ),
                              _buildStepCircle('3', isActive: false),
                              Expanded(
                                child: Container(
                                  height: 4,
                                  color: const Color(0xFFEBE8FC),
                                ),
                              ),
                              _buildStepCircle('4', isActive: false),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(height: 20),

                              _buildLabel('Minimum Followers'),
                              _buildInputField(
                                controller: _minFollowersController,
                                hintText: 'E.g 10,000',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 24),

                              _buildLabel('Number of Influencer'),
                              _buildCounterField(
                                value: _numberOfInfluencers,
                                onDecrement: () {
                                  if (_numberOfInfluencers > 1) {
                                    setState(() => _numberOfInfluencers--);
                                  }
                                },
                                onIncrement: () {
                                  setState(() => _numberOfInfluencers++);
                                },
                              ),
                              const SizedBox(height: 24),

                              _buildLabel('Deliverable by Influencer'),
                              _buildDeliverablesCard(),
                              const SizedBox(height: 24),

                              _buildLabel('Budget per Influencer'),
                              _buildBudgetField(
                                controller: _budgetController,
                                hintText: 'Amount',
                                onChanged: (_) => setState(() {}),
                              ),
                              const SizedBox(height: 8),

                              Text(
                                'Total Budget: ₹ ${_totalBudget == 0 ? '' : _totalBudget}',
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                              const SizedBox(height: 40),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
                      child: CustomButton(
                        text: 'Next',
                        isGradient: true,
                        width: double.infinity,
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Get.to(() => const Targeting1Screen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCircle(String step, {required bool isActive}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF9E8EFE) : const Color(0xFFEBE8FC),
      ),
      child: Center(
        child: Text(
          step,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              color: Color(0xFFC5C5C5),
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  Widget _buildCounterField({
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onDecrement,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.remove, color: Colors.black, size: 20),
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEBE8FC),
              border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
            ),
            child: Center(
              child: Text(
                value.toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: onIncrement,
            behavior: HitTestBehavior.opaque,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.add, color: Colors.black, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverableRow(
    String label,
    int count,
    VoidCallback onDecrement,
    VoidCallback onIncrement,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onDecrement,
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.remove, color: Colors.black, size: 20),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEBE8FC),
                  border: Border.all(
                    color: const Color(0xFFD6C8FF),
                    width: 1.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    count.toString(),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onIncrement,
                behavior: HitTestBehavior.opaque,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.add, color: Colors.black, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverablesCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildDeliverableRow(
            'Reels',
            _reelsCount,
            () {
              if (_reelsCount > 0) {
                setState(() => _reelsCount--);
              }
            },
            () {
              setState(() => _reelsCount++);
            },
          ),
          const Divider(color: Color(0xFFEBE8FC), height: 16),
          _buildDeliverableRow(
            'Story',
            _storyCount,
            () {
              if (_storyCount > 0) {
                setState(() => _storyCount--);
              }
            },
            () {
              setState(() => _storyCount++);
            },
          ),
          const Divider(color: Color(0xFFEBE8FC), height: 16),
          _buildDeliverableRow(
            'Post',
            _postCount,
            () {
              if (_postCount > 0) {
                setState(() => _postCount--);
              }
            },
            () {
              setState(() => _postCount++);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetField({
    required TextEditingController controller,
    required String hintText,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6C8FF), width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            '₹',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              onChanged: onChanged,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.black,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
