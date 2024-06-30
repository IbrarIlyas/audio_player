import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audio_app/constants.dart';
import 'package:flutter/material.dart';

class Myappbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;

  const Myappbar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 200,
      automaticallyImplyLeading: false,
      title: AnimatedTextKit(
        pause: const Duration(milliseconds: 300),
        repeatForever: true,
        animatedTexts: [
          FlickerAnimatedText(
            title,
            textStyle: mystyle(
                shadow: true,
                color_: whitecolor,
                fontSize: 18,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
