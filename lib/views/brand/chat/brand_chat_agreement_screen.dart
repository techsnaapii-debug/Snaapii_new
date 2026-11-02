import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_button.dart';
import '../../creator/creator_full_chat_screen.dart';

class BrandChatAgreementScreen extends StatefulWidget {
  final String creatorName;
  final String creatorImage;
  final String creatorHandle;
  final String brandName;
  final String brandAddress;
  final String campaignName;
  final String agreementId;
  final String effectiveDate;
  final String totalPayment;

  const BrandChatAgreementScreen({
    super.key,
    this.creatorName = 'Luna',
    this.creatorImage = 'assets/images/bancy.png',
    this.creatorHandle = '@Ritika33',
    this.brandName = 'Gucci',
    this.brandAddress = '50123 Florence, Italy.',
    this.campaignName = 'New Shoes Collection',
    this.agreementId = 'GS-917E2F98',
    this.effectiveDate = 'April 22, 2025',
    this.totalPayment = '₹[15000]',
  });

  @override
  State<BrandChatAgreementScreen> createState() =>
      _BrandChatAgreementScreenState();
}

class _BrandChatAgreementScreenState extends State<BrandChatAgreementScreen> {
  bool _isAccepted = false;

  void _handleAccept() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => _BrandOtpBottomSheetContent(
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
                  Get.off(
                    () => CreatorFullChatScreen(
                      brandName: widget.creatorName,
                      avatarImage: widget.creatorImage,
                      showSubmitLink: false,
                    ),
                  );
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
                  _buildTopBar(),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildAgreementIdCard(),

                          const SizedBox(height: 12),

                          _buildPartiesInvolvedCard(),

                          const SizedBox(height: 12),

                          _buildCampaignInfoCard(),

                          const SizedBox(height: 12),

                          _buildScopeOfWorkCard(),

                          const SizedBox(height: 12),

                          _buildContentStandardsCard(),

                          const SizedBox(height: 12),

                          _buildReviewProcessCard(),

                          const SizedBox(height: 12),

                          _buildCompensationTermsCard(),

                          const SizedBox(height: 12),

                          _buildContentRightsCard(),

                          const SizedBox(height: 12),

                          _buildBreachTerminationCard(),

                          const SizedBox(height: 12),

                          _buildDisputeResolutionCard(),

                          const SizedBox(height: 12),

                          _buildLegalValidityCard(),

                          const SizedBox(height: 12),

                          _buildAcceptanceCard(),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),

                  _buildBottomBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 1.0),
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
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: ClipOval(
              child: Image.asset(
                widget.creatorImage,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFB18CFF),
                  alignment: Alignment.center,
                  child: Text(
                    widget.creatorName.isNotEmpty ? widget.creatorName[0] : 'C',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            widget.creatorName,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1A34),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementIdCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 32, color: const Color(0xFFE5E7EB)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    fontSize: 13,
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

  Widget _buildPartiesInvolvedCard() {
    return _buildSectionCard(
      title: 'PARTIES INVOLVED',
      children: [
        const Text(
          'This Collaboration Agreement ("Agreement") is entered into between:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.5,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Influencer / Creator Details',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Color(0xFF1E1A34),
                      ),
                      children: [
                        const TextSpan(
                          text: 'Full Name: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: 'Ritika'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Color(0xFF1E1A34),
                      ),
                      children: [
                        const TextSpan(
                          text: 'Instagram Handle: \n',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: widget.creatorHandle,
                          style: const TextStyle(color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: 70,
              color: const Color(0xFFE5E7EB),
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Brand / Agency Details',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 6),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Color(0xFF1E1A34),
                      ),
                      children: [
                        const TextSpan(
                          text: 'Brand Name: ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: widget.brandName),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 11,
                        color: Color(0xFF1E1A34),
                      ),
                      children: [
                        const TextSpan(
                          text: 'Registered Address:\n',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: widget.brandAddress,
                          style: const TextStyle(color: Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCampaignInfoCard() {
    return _buildSectionCard(
      title: 'CAMPAIGN INFORMATION',
      children: [
        _buildBulletPoint(
          'Campaign Name: ${widget.campaignName}',
          isBoldTitle: true,
        ),
        const SizedBox(height: 4),
        _buildBulletPoint('Platform: Instagram', isBoldTitle: true),
      ],
    );
  }

  Widget _buildScopeOfWorkCard() {
    return _buildSectionCard(
      title: 'SCOPE OF WORK & DELIVERABLES',
      children: [
        const Text(
          'The Creator agrees to create and publish the following content:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.5,
            color: Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 6),
        _buildBulletPoint('2 Instagram Reels', isBoldTitle: true),
        const SizedBox(height: 4),
        _buildBulletPoint('1 Feed Post', isBoldTitle: true),
        const SizedBox(height: 4),
        _buildBulletPoint('1 Story', isBoldTitle: true),
      ],
    );
  }

  Widget _buildContentStandardsCard() {
    return _buildSectionCard(
      title: 'CONTENT STANDARDS & GUIDELINES',
      children: [
        _buildBulletPoint(
          'Content must be high-quality with proper lighting and clear audio',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Brand must be tagged in caption and post (collab if required)',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Use disclosure tags: #Ad #Sponsored #PaidPartnership',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Content should feel natural, engaging, and relatable',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint('Avoid forced promotion or scripted delivery'),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Do not promote competing brands in the same content',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Do not use copyrighted music, images, or videos without permission',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint('No fake engagement (likes, followers, views)'),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Avoid controversial, political, or sensitive topics',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint('Content must remain live for a minimum of 30 days'),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Creator should respond to comments for at least the first 24 hours',
        ),
      ],
    );
  }

  Widget _buildReviewProcessCard() {
    return _buildSectionCard(
      title: 'REVIEW & APPROVAL PROCESS',
      children: [
        _buildBulletPoint('Creator must submit content draft before posting'),
        const SizedBox(height: 4),
        _buildBulletPoint('Brand will provide feedback within 24-48 hours'),
        const SizedBox(height: 4),
        _buildBulletPoint('Maximum 2 revisions allowed'),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'If no response is received within the timeline, content will be considered approved',
        ),
      ],
    );
  }

  Widget _buildCompensationTermsCard() {
    return _buildSectionCard(
      title: 'COMPENSATION & PAYMENT TERMS',
      children: [
        Text(
          'Total Payment: ${widget.totalPayment}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E1A34),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Payment Terms:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1A34),
          ),
        ),
        const SizedBox(height: 3),
        _buildBulletPoint('Payment will be confirmed at the time of agreement'),
        const SizedBox(height: 3),
        _buildBulletPoint(
          'Payment will be released after successful completion of deliverables',
        ),
        const SizedBox(height: 8),
        const Text(
          'Payment Protection:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1A34),
          ),
        ),
        const SizedBox(height: 3),
        _buildBulletPoint(
          'Brand/Agency can hold payment if deliverables are incomplete',
        ),
        const SizedBox(height: 3),
        _buildBulletPoint('Partial payment may be released for partial work'),
        const SizedBox(height: 3),
        _buildBulletPoint('Payment may be cancelled in case of serious breach'),
        const SizedBox(height: 8),
        const Text(
          'Refund Conditions:',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E1A34),
          ),
        ),
        const SizedBox(height: 3),
        _buildBulletPoint('Creator fails to deliver within agreed timeline'),
        const SizedBox(height: 3),
        _buildBulletPoint('No response from creator for more than 72 hours'),
        const SizedBox(height: 3),
        _buildBulletPoint('Creator exits collaboration before execution'),
        const SizedBox(height: 3),
        _buildBulletPoint('Creator violates brand or platform guidelines'),
      ],
    );
  }

  Widget _buildContentRightsCard() {
    return _buildSectionCard(
      title: 'CONTENT RIGHTS & USAGE',
      children: [
        _buildBulletPoint('Creator retains ownership of original content'),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'Brand gets limited, non-exclusive usage rights for 60-90 days for:',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('Social media reposting'),
              const SizedBox(height: 2),
              _buildBulletPoint('Marketing and promotional use'),
              const SizedBox(height: 2),
              _buildBulletPoint('Digital advertising'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'If no response is received within the timeline, content will be considered approved',
        ),
      ],
    );
  }

  Widget _buildBreachTerminationCard() {
    return _buildSectionCard(
      title: 'BREACH & TERMINATION',
      children: [
        _buildBulletPoint('This Agreement will be considered breached if:'),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint('Creator fails to post content on time'),
              const SizedBox(height: 2),
              _buildBulletPoint(
                'Brand fails to provide required inputs or approvals',
              ),
              const SizedBox(height: 2),
              _buildBulletPoint('Content does not meet agreed standards'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDisputeResolutionCard() {
    return _buildSectionCard(
      title: 'DISPUTE RESOLUTION',
      children: [
        _buildBulletPoint(
          'Issues will first be resolved through mutual discussion',
        ),
        const SizedBox(height: 4),
        _buildBulletPoint(
          'If unresolved, jurisdiction will be Lucknow, Uttar Pradesh',
        ),
      ],
    );
  }

  Widget _buildLegalValidityCard() {
    return _buildSectionCard(
      title: 'LEGAL VALIDITY & CONSENT',
      children: [
        _buildBulletPoint(
          'This Agreement is legally valid under the Information Technology Act, 2000',
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 3.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBulletPoint(
                'Digital acceptance (OTP, email, or WhatsApp confirmation) is valid',
              ),
              const SizedBox(height: 2),
              _buildBulletPoint(
                'A digital record of this agreement will be maintained',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptanceCard() {
    return _buildSectionCard(
      title: 'ACCEPTANCE & CONFIRMATION',
      children: const [
        Text(
          'Brand Acceptance: _________',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Creator Acceptance: _________',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text, {bool isBoldTitle = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 5.0, right: 6.0),
          child: Icon(Icons.circle, size: 5, color: Color(0xFF4B5563)),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 10.5,
              fontWeight: isBoldTitle ? FontWeight.w600 : FontWeight.w400,
              color: const Color(0xFF4B5563),
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1.0)),
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
              onTap: _isAccepted ? () {} : _handleAccept,
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandOtpBottomSheetContent extends StatefulWidget {
  final VoidCallback onVerified;

  const _BrandOtpBottomSheetContent({required this.onVerified});

  @override
  State<_BrandOtpBottomSheetContent> createState() =>
      _BrandOtpBottomSheetContentState();
}

class _BrandOtpBottomSheetContentState
    extends State<_BrandOtpBottomSheetContent> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  int _resendCountdown = 30;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    for (int i = 0; i < 6; i++) {
      final index = i;
      _focusNodes[index].onKeyEvent = (node, event) {
        if (event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.backspace &&
            _controllers[index].text.isEmpty &&
            index > 0) {
          _focusNodes[index - 1].requestFocus();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      };
    }
  }

  void _startCountdown() {
    setState(() {
      _resendCountdown = 30;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 1) {
        setState(() {
          _resendCountdown--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
  }

  void _verifyOtp() {
    widget.onVerified();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: EdgeInsets.only(
        left: 24.0,
        right: 24.0,
        top: 24.0,
        bottom: bottomInset + 24.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'OTP Verification',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E1A34),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enter the 6-digit code sent to your registered phone / email to sign the agreement.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(6, (index) {
              return Container(
                width: 44,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFC4B5FD),
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                  ),
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (val) => _onDigitChanged(index, val),
                ),
              );
            }),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _canResend
                    ? 'Didn\'t receive code? '
                    : 'Resend code in 00:${_resendCountdown.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                ),
              ),
              if (_canResend)
                GestureDetector(
                  onTap: _startCountdown,
                  child: const Text(
                    'Resend',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8655FE),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Verify & Accept',
            isGradient: true,
            width: double.infinity,
            height: 50.0,
            borderRadius: 28.0,
            fontSize: 15.0,
            textColor: Colors.white,
            onTap: _verifyOtp,
          ),
        ],
      ),
    );
  }
}
