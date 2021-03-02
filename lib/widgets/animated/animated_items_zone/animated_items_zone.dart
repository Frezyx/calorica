import 'package:calory_calc/widgets/animated/animated_items_zone/src/src.dart';
import 'package:flutter/material.dart';

class AnimatedZone extends StatelessWidget {
  AnimatedZone({
    Key key,
    this.animated = true,
  }) : super(key: key);

  final bool animated;

  var controllers = <AnimationController>[];

  @override
  Widget build(BuildContext context) {
    if (!animated) {
      controllers.forEach((e) => e.dispose());
    }
    final theme = Theme.of(context);
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: AnimatedZoneItem(
            color: theme.primaryColor,
            size: 30,
            onCreate: (AnimationController controller) {
              _onControllerCreate(controller, Duration(milliseconds: 300));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: AnimatedZoneItem(
              size: 55,
              color: Color(0xFF0F972D),
              onCreate: (AnimationController controller) {
                _onControllerCreate(controller, Duration(milliseconds: 900));
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: AnimatedZoneItem(
            size: 20,
            color: Color(0xFF076C1D),
            onCreate: (AnimationController controller) {
              _onControllerCreate(controller, Duration(milliseconds: 1500));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: Align(
            alignment: Alignment.topRight,
            child: AnimatedZoneItem(
              size: 70,
              color: theme.primaryColor,
              onCreate: (AnimationController controller) {
                _onControllerCreate(controller, Duration(milliseconds: 500));
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: AnimatedZoneItem(
            size: 30,
            color: theme.primaryColor.withOpacity(0.5),
            onCreate: (AnimationController controller) {
              _onControllerCreate(controller, Duration(milliseconds: 1600));
            },
          ),
        ),
      ],
    );
  }

  void _onControllerCreate(AnimationController controller, Duration duration) {
    controllers.add(controller);
    Future.delayed(duration).then((value) => controller.repeat(
          reverse: true,
        ));
  }
}
