import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(
        Images.notActive,
      ),
    );
  }
}
