import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp_with_flutterhooks/core/theme/app_theme.dart';

class AnimatedText extends StatelessWidget {
  final String text;

  const AnimatedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          cursor: '',
          textStyle: const TextStyle(
            fontSize: 40.0,
            overflow: TextOverflow.ellipsis,
            fontWeight: w7,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
      repeatForever: false,
    );
  }
}
