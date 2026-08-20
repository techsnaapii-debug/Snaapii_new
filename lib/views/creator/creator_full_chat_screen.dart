import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum ChatMessageType { text, image, video, influencerOffer, counterOffer }

class ChatMessageModel {
  final ChatMessageType type;
  final String? text;
  final File? mediaFile;
  final String? offerAmount;
  final String? offerMessage;
  final String time;

  ChatMessageModel({
    required this.type,
    this.text,
    this.mediaFile,
    this.offerAmount,
    this.offerMessage,
    required this.time,
  });
}

class CreatorFullChatScreen extends StatefulWidget {
  final String brandName;
  final String brandInitial;
  final Color brandBgColor;
  final String? avatarImage;
  final bool showSubmitLink;
  final bool isBrandView;

  const CreatorFullChatScreen({
    super.key,
    this.brandName = 'Gucci',
    this.brandInitial = 'GUCCI',
    this.brandBgColor = const Color(0xFF4A0010),
    this.avatarImage,
    this.showSubmitLink = true,
    this.isBrandView = false,
  });

  @override
  State<CreatorFullChatScreen> createState() => _CreatorFullChatScreenState();
}

class _CreatorFullChatScreenState extends State<CreatorFullChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _imagePicker = ImagePicker();

  final List<ChatMessageModel> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
        backgroundColor: const Color(0xFFFAFAFA),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  _buildTopBar(),

                  Expanded(
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 12.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (!widget.isBrandView) _buildCampaignOfferCard(),

                          for (var msg in _messages) ...[
                            const SizedBox(height: 10),
                            if (msg.type == ChatMessageType.text)
                              _buildCreatorMessage(msg.text!, msg.time)
                            else if (msg.type ==
                                ChatMessageType.influencerOffer)
                              _buildInfluencerOfferChatBubble(
                                msg.offerAmount ?? '₹ 12000',
                                msg.offerMessage ?? '',
                                msg.time,
                              )
                            else if (msg.type == ChatMessageType.counterOffer)
                              _buildCounterOfferChatBubble(
                                msg.offerAmount ?? '₹11000',
                                msg.time,
                              )
                            else
                              _buildMediaBubble(
                                msg.mediaFile!,
                                msg.type == ChatMessageType.video,
                                msg.time,
                              ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  _buildBottomInputBar(),
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
          const SizedBox(width: 8),
          if (widget.avatarImage != null)
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipOval(
                child: Image.asset(
                  widget.avatarImage!,
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF8655FE),
                    alignment: Alignment.center,
                    child: Text(
                      widget.brandName.isNotEmpty ? widget.brandName[0] : 'U',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          else
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
    );
  }

  Widget _buildCampaignOfferCard() {
    return Align(
      alignment: Alignment.centerLeft,
      child: IntrinsicWidth(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'Campaign Offer',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1A34),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Divider(color: Color(0xFFF3F4F6), height: 1, thickness: 1),
              const SizedBox(height: 10),
              const Text(
                'Offer: ₹ 10000',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Formats: Instagram Reel',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF4B5563),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA78BFA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: _showMakeAnOfferDialog,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFD1D5DB)),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Make an Offer',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1E1A34),
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

  void _showMakeAnOfferDialog() {
    if (widget.isBrandView) {
      _showBrandCounterOfferDialog();
    } else {
      _showCreatorInfluencerOfferDialog();
    }
  }

  void _showBrandCounterOfferDialog() {
    final TextEditingController amountController = TextEditingController(
      text: '₹11000',
    );

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
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
              const Center(
                child: Text(
                  'Counter Offer',
                  style: TextStyle(
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
                  controller: amountController,
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
              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () {
                    final amount = amountController.text.trim();

                    if (amount.isNotEmpty) {
                      final now = DateTime.now();
                      final hour = now.hour > 12
                          ? now.hour - 12
                          : (now.hour == 0 ? 12 : now.hour);
                      final minute = now.minute.toString().padLeft(2, '0');
                      final period = now.hour >= 12 ? 'PM' : 'AM';
                      final formattedTime = '$hour:$minute $period';

                      setState(() {
                        _messages.add(
                          ChatMessageModel(
                            type: ChatMessageType.counterOffer,
                            offerAmount: amount,
                            time: formattedTime,
                          ),
                        );
                      });
                      _scrollToBottom();
                    }
                    Navigator.of(dialogContext).pop();
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
      ),
    );
  }

  void _showCreatorInfluencerOfferDialog() {
    final TextEditingController amountController = TextEditingController(
      text: '₹ 12000',
    );
    final TextEditingController messageController = TextEditingController(
      text: 'According to the profile , I was expecting more.',
    );

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
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
              const Center(
                child: Text(
                  'Infuencer Offer',
                  style: TextStyle(
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
                  controller: amountController,
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
                  controller: messageController,
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
              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () {
                    final amount = amountController.text.trim();
                    final msg = messageController.text.trim();

                    if (amount.isNotEmpty) {
                      final now = DateTime.now();
                      final hour = now.hour > 12
                          ? now.hour - 12
                          : (now.hour == 0 ? 12 : now.hour);
                      final minute = now.minute.toString().padLeft(2, '0');
                      final period = now.hour >= 12 ? 'PM' : 'AM';
                      final formattedTime = '$hour:$minute $period';

                      setState(() {
                        _messages.add(
                          ChatMessageModel(
                            type: ChatMessageType.influencerOffer,
                            offerAmount: amount,
                            offerMessage: msg,
                            time: formattedTime,
                          ),
                        );
                      });
                      _scrollToBottom();
                    }
                    Navigator.of(dialogContext).pop();
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
      ),
    );
  }

  Widget _buildCounterOfferChatBubble(String amount, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF0EBFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDDD2FE), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Counter Offer',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Divider(color: Color(0xFFDDD2FE), height: 1, thickness: 1),
            const SizedBox(height: 8),
            const Text(
              'Your Offer Amount',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1A34),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFA78BFA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8.5,
                  color: Color(0xFF888888),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfluencerOfferChatBubble(
    String amount,
    String message,
    String time,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF0EBFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFDDD2FE), width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Infuencer Offer',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E1A34),
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Divider(color: Color(0xFFDDD2FE), height: 1, thickness: 1),
            const SizedBox(height: 8),
            const Text(
              'Your Offer Amount',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E1A34),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFA78BFA),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                amount,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (message.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                'Message',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1A34),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFA78BFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11.5,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                time,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8.5,
                  color: Color(0xFF888888),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatorMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.76,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: const BoxDecoration(
          color: Color(0xFFF1EAFF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14),
            topRight: Radius.circular(14),
            bottomLeft: Radius.circular(14),
            bottomRight: Radius.circular(4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: Color(0xFF1E1A34),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 9.5,
                fontWeight: FontWeight.w400,
                color: Color(0xFF888888),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMediaBubble(File file, bool isVideo, String time) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 140,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1A34),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(file, fit: BoxFit.cover),
              if (isVideo) ...[
                Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.videocam_rounded,
                          color: Colors.white,
                          size: 13,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Video',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 1.5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 8.5,
                      color: Colors.white,
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

  Widget _buildBottomInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6), width: 1.0)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showAttachmentOptions,
            child: Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFB18CFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 26),
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: const InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF9CA3AF),
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    behavior: HitTestBehavior.opaque,
                    child: const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.send_outlined,
                        color: Color(0xFF6B7280),
                        size: 20,
                      ),
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

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    final formattedTime = '$hour:$minute $period';

    setState(() {
      _messages.add(
        ChatMessageModel(
          type: ChatMessageType.text,
          text: text,
          time: formattedTime,
        ),
      );
      _messageController.clear();
    });

    _scrollToBottom();
  }

  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const SizedBox(height: 18),
            const Text(
              'Share Content',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E1A34),
              ),
            ),
            const SizedBox(height: 16),
            _buildAttachmentOptionItem(
              icon: Icons.camera_alt_rounded,
              title: 'Camera',
              subtitle: 'Take a photo or record a video',
              onTap: () {
                Navigator.of(bottomSheetContext).pop();
                _pickMedia(ImageSource.camera);
              },
            ),
            const SizedBox(height: 12),
            _buildAttachmentOptionItem(
              icon: Icons.photo_library_rounded,
              title: 'Gallery',
              subtitle: 'Choose photo or video from library',
              onTap: () {
                Navigator.of(bottomSheetContext).pop();
                _pickMedia(ImageSource.gallery);
              },
            ),
            if (widget.showSubmitLink) ...[
              const SizedBox(height: 12),
              _buildAttachmentOptionItem(
                icon: Icons.link_rounded,
                title: 'Submit Link',
                subtitle: 'Submit campaign post or reel link',
                onTap: () {
                  Navigator.of(bottomSheetContext).pop();
                  _showSubmitFinalLinkDialog();
                },
              ),
            ],
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showSubmitFinalLinkDialog() {
    final List<TextEditingController> linkControllers = [
      TextEditingController(),
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) {
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

                    for (int i = 0; i < linkControllers.length; i++) ...[
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
                          controller: linkControllers[i],
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
                        setDialogState(() {
                          linkControllers.add(TextEditingController());
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
                          onTap: () {
                            Navigator.of(dialogContext).pop();
                          },
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
                            final List<String> validLinks = linkControllers
                                .map((c) => c.text.trim())
                                .where((t) => t.isNotEmpty)
                                .toList();

                            if (validLinks.isNotEmpty) {
                              final now = DateTime.now();
                              final hour = now.hour > 12
                                  ? now.hour - 12
                                  : (now.hour == 0 ? 12 : now.hour);
                              final minute = now.minute.toString().padLeft(
                                2,
                                '0',
                              );
                              final period = now.hour >= 12 ? 'PM' : 'AM';
                              final formattedTime = '$hour:$minute $period';

                              setState(() {
                                for (var link in validLinks) {
                                  _messages.add(
                                    ChatMessageModel(
                                      type: ChatMessageType.text,
                                      text: link,
                                      time: formattedTime,
                                    ),
                                  );
                                }
                              });
                              _scrollToBottom();
                            }
                            Navigator.of(dialogContext).pop();
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
        },
      ),
    );
  }

  Widget _buildAttachmentOptionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.2),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFEDE9FE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xFF8655FE), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E1A34),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11.5,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickMedia(ImageSource source) async {
    try {
      final XFile? file = source == ImageSource.gallery
          ? await _imagePicker.pickMedia(imageQuality: 85)
          : await _imagePicker.pickImage(source: source, imageQuality: 85);

      if (file != null) {
        final now = DateTime.now();
        final hour = now.hour > 12
            ? now.hour - 12
            : (now.hour == 0 ? 12 : now.hour);
        final minute = now.minute.toString().padLeft(2, '0');
        final period = now.hour >= 12 ? 'PM' : 'AM';
        final formattedTime = '$hour:$minute $period';

        final path = file.path.toLowerCase();
        final isVideo =
            path.endsWith('.mp4') ||
            path.endsWith('.mov') ||
            path.endsWith('.avi') ||
            path.endsWith('.mkv') ||
            path.endsWith('.webm');

        setState(() {
          _messages.add(
            ChatMessageModel(
              type: isVideo ? ChatMessageType.video : ChatMessageType.image,
              mediaFile: File(file.path),
              time: formattedTime,
            ),
          );
        });

        _scrollToBottom();
      }
    } catch (e) {
      debugPrint('Error picking media: $e');
    }
  }
}
