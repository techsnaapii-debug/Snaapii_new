import 'dart:io';
import 'package:flutter/material.dart';
import 'story_preview_screen.dart';

class StoryPreview2Screen extends StatelessWidget {
  final String? storyImage;
  final File? selectedFile;
  final String? username;
  final String? automationName;
  final String? keyword;
  final String? message;
  final String? openingMessageText;
  final String? visitProfileText;
  final String? followingText;
  final String? linkTitle;
  final String? linkUrl;

  const StoryPreview2Screen({
    super.key,
    this.storyImage,
    this.selectedFile,
    this.username,
    this.automationName,
    this.keyword,
    this.message,
    this.openingMessageText,
    this.visitProfileText,
    this.followingText,
    this.linkTitle,
    this.linkUrl,
  });

  @override
  Widget build(BuildContext context) {
    return StoryPreviewScreen(
      storyImage: storyImage,
      selectedFile: selectedFile,
      username: username,
      automationName: automationName,
      keyword: keyword,
      message: message,
      openingMessageText: openingMessageText,
      visitProfileText: visitProfileText,
      followingText: followingText,
      linkTitle: linkTitle,
      linkUrl: linkUrl,
      initialPageIndex: 1,
    );
  }
}
