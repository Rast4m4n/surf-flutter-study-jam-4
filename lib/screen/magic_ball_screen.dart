import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/data/api/services/eight_ball_api.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_vm.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  final IMagicBallViewModel vm = MagicBallViewModel(
    model: EightBallModel(
      reading: '',
    ),
    api: EightBallApi(),
  );

  @override
  void initState() {
    super.initState();

    vm.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        vm.getBallResponse();
      });
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 14, 44),
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: vm.getBallResponse,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: _EightBall(vm: vm),
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

class _EightBall extends StatefulWidget {
  const _EightBall({
    super.key,
    required this.vm,
  });

  final IMagicBallViewModel vm;

  @override
  State<_EightBall> createState() => _EightBallState();
}

class _EightBallState extends State<_EightBall> {
  @override
  void initState() {
    super.initState();
    flyBall();
  }

  final durationAnimation = const Duration(seconds: 1);

  void flyBall() {
    if (!widget.vm.isHiddenStars) {
      isdown = !isdown;
      setState(() {});
      Future.delayed(durationAnimation, () {
        flyBall();
      });
    }
  }

  bool isdown = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: durationAnimation,
      alignment: isdown ? Alignment.center : AlignmentDirectional.topCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            widget.vm.imagePath,
          ),
          if (!widget.vm.isHiddenStars)
            Image.asset(
              Images.smallStar,
              fit: BoxFit.contain,
            ),
          if (!widget.vm.isHiddenStars)
            Image.asset(
              Images.star,
              fit: BoxFit.contain,
            ),
          AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FadeAnimatedText(
                widget.vm.model.reading,
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
