import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_vm.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  final IMagicBallViewModel vm = MockMagicBallViewModel();

  @override
  void initState() {
    super.initState();
    vm.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 14, 44),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: vm.ballResponse,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        vm.imagePath,
                      ),
                      if (!vm.isHiddenStars)
                        Image.asset(
                          Images.smallStar,
                          fit: BoxFit.contain,
                        ),
                      if (!vm.isHiddenStars)
                        Image.asset(
                          Images.star,
                          fit: BoxFit.contain,
                        ),
                      Text(
                        vm.text,
                        style:
                            Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        Images.ellipse6,
                      ),
                      Image.asset(
                        Images.ellipse7,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Нажмите на экран или потрясите телефон',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
