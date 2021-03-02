import 'package:flutter/material.dart';

class AnimatedZoneItem extends StatefulWidget {
  const AnimatedZoneItem({
    Key key,
    this.curve = Curves.bounceIn,
    this.size = 50,
    this.color = Colors.black,
    @required this.onCreate,
  }) : super(key: key);

  final Curve curve;
  final double size;
  final Color color;
  final Function(AnimationController controller) onCreate;

  @override
  _AnimatedZoneItemState createState() => _AnimatedZoneItemState();
}

class _AnimatedZoneItemState extends State<AnimatedZoneItem>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _animation = Tween(begin: -150.0, end: 75.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
    );
    widget.onCreate(_animationController);
    super.initState();
  }

  AnimationController _animationController;
  Animation _animation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return Container(
          transform: Matrix4.translationValues(
            0,
            _animation.value,
            0,
          ),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        );
      },
    );
  }
}
