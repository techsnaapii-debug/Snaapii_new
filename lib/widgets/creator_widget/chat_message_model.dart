import 'dart:io';

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
