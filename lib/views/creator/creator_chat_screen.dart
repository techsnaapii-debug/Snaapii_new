import 'package:flutter/material.dart';

import '../shared/deals_screen.dart';

class CreatorChatScreen extends StatelessWidget {
  const CreatorChatScreen({super.key});

  @override
  Widget build(BuildContext context) => const DealsScreen(isCreator: true);
}
