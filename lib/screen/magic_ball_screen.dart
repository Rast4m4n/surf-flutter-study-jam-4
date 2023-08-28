import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/data/api/services/eight_ball_api.dart';
import 'package:surf_practice_magic_ball/domain/model/eight_ball_model.dart';
import 'package:surf_practice_magic_ball/resources/resources.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_animation.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_vm.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  late final IMagicBallViewModel vm = MagicBallViewModel(
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
    ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        vm.getBallResponse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: vm.getBallResponse,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 25, 14, 44),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: _EightBallWidget(vm: vm),
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        vm.isBallResponseError
                            ? Images.bigShadowRed
                            : Images.bigShadowBlue,
                      ),
                      Image.asset(
                        vm.isBallResponseError
                            ? Images.smallShadowRed
                            : Images.smallShadowBlue,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Нажмите на экран или потрясите телефон',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xff727272),
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

class _EightBallWidget extends StatefulWidget {
  const _EightBallWidget({
    super.key,
    required this.vm,
  });

  final IMagicBallViewModel vm;

  @override
  State<_EightBallWidget> createState() => EightBallWidgetState();
}

class EightBallWidgetState extends State<_EightBallWidget>
    with TickerProviderStateMixin {
  late final IMagicBallAnimationModel animationModel = MagicBallAnimationModel(
    vm: widget.vm,
    magicBallWidget: this,
  );

  @override
  void initState() {
    super.initState();
    animationModel.addListener(() {
      setState(() {});
    });
    animationModel.flyBall();
  }

  @override
  void dispose() {
    super.dispose();
    animationModel.disposeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationModel.durationAnimation,
      curve: Curves.easeInOut,
      alignment: animationModel.isDown
          ? Alignment.bottomCenter
          : AlignmentDirectional.topCenter,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            widget.vm.imageBallPath,
          ),
          if (!widget.vm.isHiddenStars)
            Image.asset(
              Images.smallStar,
              fit: BoxFit.contain,
            ),
          if (!widget.vm.isHiddenStars)
            RotationTransition(
              turns: animationModel.animationRotation,
              child: Image.asset(
                Images.star,
                fit: BoxFit.contain,
              ),
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
