import 'package:flutter/material.dart';

class MarqueeText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const MarqueeText({super.key, required this.text, required this.style});

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _offsetAnimation = TweenSequence<Offset>([
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: const Offset(1.5, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 20,
      ),
      TweenSequenceItem(tween: ConstantTween<Offset>(Offset.zero), weight: 50),
      TweenSequenceItem(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.5, 0.0),
        ).chain(CurveTween(curve: Curves.fastOutSlowIn)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: ConstantTween<Offset>(const Offset(1.5, 0.0)),
        weight: 10,
      ),
    ]).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Text(
        widget.text,
        style: widget.style,
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
