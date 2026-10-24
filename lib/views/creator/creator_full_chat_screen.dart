import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snaapii/widgets/creator_widget/attachment_option_item.dart';
import 'package:snaapii/widgets/creator_widget/campaign_offer_card.dart';
import 'package:snaapii/widgets/creator_widget/chat_bottom_input_bar.dart';
import 'package:snaapii/widgets/creator_widget/chat_message_bubbles.dart';
import 'package:snaapii/widgets/creator_widget/chat_message_model.dart';
import 'package:snaapii/widgets/creator_widget/creator_chat_top_bar.dart';
import 'package:snaapii/widgets/creator_widget/make_offer_dialog.dart';
import 'package:snaapii/widgets/creator_widget/submit_final_link_dialog.dart';

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
                  CreatorChatTopBar(
                    brandName: widget.brandName,
                    brandInitial: widget.brandInitial,
                    brandBgColor: widget.brandBgColor,
                    avatarImage: widget.avatarImage,
                  ),

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
                          if (!widget.isBrandView)
                            CampaignOfferCard(
                              onMakeOffer: _showMakeAnOfferDialog,
                            ),

                          for (var msg in _messages) ...[
                            const SizedBox(height: 10),
                            if (msg.type == ChatMessageType.text)
                              CreatorChatMessageBubble(
                                text: msg.text!,
                                time: msg.time,
                              )
                            else if (msg.type ==
                                ChatMessageType.influencerOffer)
                              InfluencerOfferChatBubble(
                                amount: msg.offerAmount ?? '₹ 12000',
                                message: msg.offerMessage ?? '',
                                time: msg.time,
                              )
                            else if (msg.type == ChatMessageType.counterOffer)
                              CounterOfferChatBubble(
                                amount: msg.offerAmount ?? '₹11000',
                                time: msg.time,
                              )
                            else
                              MediaChatBubble(
                                file: msg.mediaFile!,
                                isVideo: msg.type == ChatMessageType.video,
                                time: msg.time,
                              ),
                          ],
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),

                  ChatBottomInputBar(
                    controller: _messageController,
                    onAddTap: _showAttachmentOptions,
                    onSendTap: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMakeAnOfferDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => MakeOfferDialog(
        isBrandView: widget.isBrandView,
        onSendOffer: (amount, message) {
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
                type: widget.isBrandView
                    ? ChatMessageType.counterOffer
                    : ChatMessageType.influencerOffer,
                offerAmount: amount,
                offerMessage: message,
                time: formattedTime,
              ),
            );
          });
          _scrollToBottom();
        },
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
            AttachmentOptionItem(
              icon: Icons.camera_alt_rounded,
              title: 'Camera',
              subtitle: 'Take a photo or record a video',
              onTap: () {
                Navigator.of(bottomSheetContext).pop();
                _pickMedia(ImageSource.camera);
              },
            ),
            const SizedBox(height: 12),
            AttachmentOptionItem(
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
              AttachmentOptionItem(
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
    showDialog(
      context: context,
      builder: (dialogContext) => SubmitFinalLinkDialog(
        onSubmit: (validLinks) {
          final now = DateTime.now();
          final hour = now.hour > 12
              ? now.hour - 12
              : (now.hour == 0 ? 12 : now.hour);
          final minute = now.minute.toString().padLeft(2, '0');
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
        },
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
