import 'package:flutter/material.dart';

import '../../creator/creator_chat_screen.dart';
import '../../shared/deals_screen.dart';
import '../my_campaign/home_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) => HomeScreen.isCreatorRole
      ? const CreatorChatScreen()
      : const DealsScreen(isCreator: false);
}
