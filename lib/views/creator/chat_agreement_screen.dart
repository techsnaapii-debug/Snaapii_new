import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/creator_widget/otp_bottom_sheet_content.dart';
import 'creator_full_chat_screen.dart';

class ChatAgreementScreen extends StatefulWidget {
  final String brandName;
  final String brandInitial;
  final Color brandBgColor;
  final String creatorName;
  final String creatorHandle;
  final String campaignName;
  final String agreementId;
  final String effectiveDate;
  final String totalPayment;
  final String registeredAddress;

  const ChatAgreementScreen({
    super.key,
    this.brandName = 'Gucci',
    this.brandInitial = 'GUCCI',
    this.brandBgColor = const Color(0xFF4A0010),
    this.creatorName = 'Ritika',
    this.creatorHandle = '@Ritika22',
    this.campaignName = 'New Shoes Collection',
    this.agreementId = 'AF556AF2',
    this.effectiveDate = 'October 28, 2025',
    this.totalPayment = '₹[15000]',
    this.registeredAddress = 'Hill Road, Mumbai, Maharashtra – 400051',
  });

  @override
  State<ChatAgreementScreen> createState() => _ChatAgreementScreenState();
}

class _ChatAgreementScreenState extends State<ChatAgreementScreen> {
  bool _isAccepted = false;

  void _handleAccept() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => OtpBottomSheetContent(
        onVerified: () {
          Navigator.of(bottomSheetContext).pop();
          setState(() {
            _isAccepted = true;
          });
          _showSuccessDialog();
        },
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 78,
                height: 78,
                decoration: const BoxDecoration(
                  color: Color(0xFF22C55E),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Accepted',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'You have successfully accepted the Contract now you can continue the chat.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  _showReminderNoteDialog();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFFC4B5FD),
                      width: 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8655FE),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReminderNoteDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Reminder Note',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFFE5E7EB), thickness: 1, height: 1),
              const SizedBox(height: 16),

              const Text(
                'Deliverable',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 10.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE8FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.smart_display_outlined,
                            color: Color(0xFF8655FE),
                            size: 22,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Reel 1',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8655FE),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 1.2,
                      height: 28,
                      color: const Color(0xFFC4B5FD),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.play_circle_outline_rounded,
                            color: Color(0xFF8655FE),
                            size: 22,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Story 1',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8655FE),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 1.2,
                      height: 28,
                      color: const Color(0xFFC4B5FD),
                    ),

                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/instagram_icon.png',
                            width: 20,
                            height: 20,
                            color: const Color(0xFF8655FE),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            'Post 1',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8655FE),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              const Text(
                'About Campaign',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Artificial Intelligence (AI) is technology enabling machines to mimic human intelligence, learning from data to reason, solve problems.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4B5563),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 24),

              CustomButton(
                text: 'Continue to Chat',
                isGradient: true,
                width: double.infinity,
                height: 50.0,
                borderRadius: 30.0,
                fontSize: 15.5,
                textColor: Colors.white,
                onTap: () {
                  Navigator.of(dialogContext).pop();
                  Get.off(
                    () => CreatorFullChatScreen(
                      brandName: widget.brandName,
                      brandInitial: widget.brandInitial,
                      brandBgColor: widget.brandBgColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
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
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 10.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFF3F4F6),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          behavior: HitTestBehavior.opaque,
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xFF8655FE),
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: widget.brandBgColor,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            widget.brandInitial,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 8.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.brandName,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E1A34),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildHeaderBanner(),

                          const SizedBox(height: 12),

                          _buildMetadataCard(),

                          const SizedBox(height: 12),

                          _buildPartiesAndCampaignCard(),

                          const SizedBox(height: 12),

                          _buildScopeOfWorkCard(),

                          const SizedBox(height: 12),

                          _buildCompensationCard(),

                          const SizedBox(height: 12),

                          _buildContentOwnershipCard(),

                          const SizedBox(height: 12),

                          _buildBreachCard(),

                          const SizedBox(height: 12),

                          _buildDisputeCard(),

                          const SizedBox(height: 12),

                          _buildLegalValidityCard(),

                          const SizedBox(height: 12),

                          _buildAcceptanceConfirmationCard(),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  _buildBottomActionBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF9E8EFE),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF9E8EFE).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.assignment_outlined,
              color: Color(0xFF8655FE),
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Collaboration Agreement',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Please review all terms and conditions carefully before accepting',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetadataCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Agreement ID :',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.agreementId,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1.2, height: 32, color: const Color(0xFFE5E7EB)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Effective Date :',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.effectiveDate,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartiesAndCampaignCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'PARTIES TO THE AGREEMENT',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'This Collaboration Agreement (“Agreement”) is entered into between the following parties:',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B5563),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Creator Details',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E1A34),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.5,
                            color: Color(0xFF1E1A34),
                            height: 1.35,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Full Name: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: widget.creatorName),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.5,
                            color: Color(0xFF1E1A34),
                            height: 1.35,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Instagram Handle:\n',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: widget.creatorHandle),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1.0,
                  height: 90,
                  color: const Color(0xFFE5E7EB),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Brand / Agency Details',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E1A34),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.5,
                            color: Color(0xFF1E1A34),
                            height: 1.35,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Brand Name: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: widget.brandName),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 10.5,
                            color: Color(0xFF1E1A34),
                            height: 1.35,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Registered Address: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: widget.registeredAddress),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'CAMPAIGN DETAILS',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11,
                  color: Color(0xFF1E1A34),
                  height: 1.35,
                ),
                children: [
                  const TextSpan(text: '• '),
                  const TextSpan(
                    text: 'Campaign Name: ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(text: widget.campaignName),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScopeOfWorkCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'SCOPE OF WORK & DELIVERABLES',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'The Creator agrees to produce and publish content as per the following:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B5563),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Deliverables:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildBulletItem('1 Instagram Reel'),
          _buildBulletItem('1 Story'),
          const SizedBox(height: 10),
          const Text(
            'Content Requirements:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildBulletItem(
            'Content must be visually appealing with proper lighting and clear audio',
          ),
          _buildBulletItem(
            'Brand must be tagged in both caption and post (collab post if mutually agreed)',
          ),
          _buildBulletItem(
            'Creator should actively engage with audience comments for at least 24 hours',
          ),
          _buildBulletItem(
            'Draft content must be shared with the brand prior to posting for approval',
          ),
          _buildBulletItem(
            'Content once published should not be deleted, hidden, or archived',
          ),
          _buildBulletItem(
            'Artificial engagement (fake likes, comments, followers, or views) is strictly prohibited',
          ),
          _buildBulletItem(
            'Only licensed or original music, visuals, and assets should be used',
          ),
          const SizedBox(height: 10),
          const Text(
            'Review & Approval:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildBulletItem(
            'Brand will review submitted draft within 24–48 hours',
          ),
          _buildBulletItem('Posting time will be mutually decided in advance'),
          _buildBulletItem(
            'Feedback timeline post submission will follow agreed communication (chat/email)',
          ),
        ],
      ),
    );
  }

  Widget _buildCompensationCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'COMPENSATION & PAYMENT TERMS',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.5,
                color: Color(0xFF1E1A34),
              ),
              children: [
                const TextSpan(
                  text: 'Total Payment: ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: widget.totalPayment,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Payment Terms:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildBulletItem(
            'Full payment will be secured at the time of agreement confirmation',
          ),
          _buildBulletItem(
            'Payment will be released after successful completion of all deliverables',
          ),
          const SizedBox(height: 10),
          const Text(
            'Payment Protection:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildBulletItem(
            'Payment may be withheld if deliverables are not completed as agreed',
          ),
          _buildBulletItem(
            'Partial payments may be considered for partial work (if applicable)',
          ),
          _buildBulletItem(
            'In case of major non-compliance, payment may be cancelled',
          ),
          const SizedBox(height: 10),
          const Text(
            'Refund Conditions:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildBulletItem('Creator fails to deliver within agreed timeline'),
          _buildBulletItem(
            'Creator becomes unresponsive for more than 72 hours despite follow-ups',
          ),
          _buildBulletItem('Creator withdraws before executing deliverables'),
          _buildBulletItem('Creator violates platform or brand guidelines'),
        ],
      ),
    );
  }

  Widget _buildContentOwnershipCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'CONTENT OWNERSHIP & USAGE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletItem(
            'Creator retains full ownership of the original content',
          ),
          _buildBulletItem(
            'Content will be published on the creator’s own profile',
          ),
          const SizedBox(height: 10),
          const Text(
            'Usage Rights:',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 4),
          _buildDashItem(
            'Brand may request a collaboration post (subject to creator approval)',
          ),
          _buildDashItem(
            'Brand does not have rights to reuse, edit, promote, or repurpose content without prior written consent',
          ),
          _buildDashItem(
            'Any additional usage beyond the agreed scope will require separate approval',
          ),
        ],
      ),
    );
  }

  Widget _buildBreachCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'BREACH & TERMINATION',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletItem('This Agreement shall be considered breached if:'),
          const SizedBox(height: 2),
          _buildDashItem(
            'Creator does not publish content within the agreed timeline',
          ),
          _buildDashItem(
            'Brand fails to provide required inputs, approvals, or communication',
          ),
          _buildDashItem(
            'Content significantly deviates from agreed guidelines',
          ),
        ],
      ),
    );
  }

  Widget _buildDisputeCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'DISPUTE RESOLUTION',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletItem(
            'Parties will first attempt to resolve issues through mutual discussion',
          ),
          _buildBulletItem(
            'If unresolved, the matter may proceed to arbitration under Lucknow jurisdiction',
          ),
        ],
      ),
    );
  }

  Widget _buildLegalValidityCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'LEGAL VALIDITY & CONSENT',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.4,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _buildBulletItem(
            'This Agreement is legally valid under the Information Technology Act, 2000',
          ),
          _buildBulletItem(
            'Digital acceptance via OTP, email, or platform confirmation is considered valid consent',
          ),
          _buildBulletItem(
            'A secure digital record of this Agreement will be maintained',
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptanceConfirmationCard() {
    return _buildSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ACCEPTANCE & CONFIRMATION',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Color(0xFF1E1A34),
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text: 'Brand Acceptance: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: '________',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Color(0xFF1E1A34),
                        height: 1.4,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Creator Acceptance: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: _isAccepted ? widget.creatorName : '________',
                          style: TextStyle(
                            color: _isAccepted
                                ? const Color(0xFF8655FE)
                                : const Color(0xFF9CA3AF),
                            fontWeight: _isAccepted
                                ? FontWeight.w700
                                : FontWeight.normal,
                            letterSpacing: _isAccepted ? 0.0 : 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: CustomButton(
              text: 'Decline',
              isGradient: false,
              backgroundColor: Colors.white,
              borderColor: const Color(0xFFD6C8FF),
              textColor: Colors.black,
              fontSize: 16.0,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            flex: 6,
            child: CustomButton(
              text: 'Accept Agreement',
              isGradient: true,
              textColor: Colors.white,
              fontSize: 16.0,
              onTap: _handleAccept,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
      ),
      child: child,
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10.5,
                fontWeight: FontWeight.w400,
                color: Color(0xFF374151),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '- ',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4B5563),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 10.5,
                fontWeight: FontWeight.w400,
                color: Color(0xFF4B5563),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

