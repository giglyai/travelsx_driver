import 'package:flutter/material.dart';

import '../../constants/app_colors/app_colors.dart';
import '../size_config/size_config.dart';

class CustomSwipableButton extends StatefulWidget {
  final String? title;
  final VoidCallback onConfirmation;
  final bool? disable;
  const CustomSwipableButton({
    Key? key,
    this.title,
    required this.onConfirmation,
    this.disable = false,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return CustomSwipableButtonState();
  }
}

class CustomSwipableButtonState extends State<CustomSwipableButton> {
  final _buttonWidth = 56.0;
  double _position = 0;
  int _duration = 0;
  bool _isSwiped = false;
  bool isChanging = false;
  final BorderRadius _borderRadius = BorderRadius.circular(4.0);
  double getPosition(widthConstraint) {
    if (widget.disable!) _position = 0;
    if (_position < 0) {
      return 0;
    } else if (_position > widthConstraint - _buttonWidth) {
      return widthConstraint - _buttonWidth;
    } else {
      return _position;
    }
  }

  void updatePosition(details, widthConstraint) {
    if (!widget.disable!) {
      if (details is DragEndDetails) {
        setState(() {
          _duration = 100;
          _position = _isSwiped ? widthConstraint : 0;
          isChanging = false;
        });
      } else if (details is DragUpdateDetails) {
        setState(() {
          isChanging = true;
          _duration = 0;
          _position = _isSwiped ? _position : details.localPosition.dx;
        });
      }
    } else {
      _position = 0;
    }
  }

  void swipeReleased(details, widthConstraint) {
    if (_position > widthConstraint - _buttonWidth) {
      widget.onConfirmation();
      _isSwiped = true;
      Future.delayed(const Duration(milliseconds: 400), () {
        if (mounted) {
          setState(() {
            _position = 0;
            _isSwiped = false;
          });
        }
      });
      // hapticHandler(ImpactLevel.medium);
    }
    updatePosition(details, widthConstraint);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        height: 60.0 * SizeConfig.heightMultiplier!,
        width: constraints.maxWidth,
        decoration: BoxDecoration(
          borderRadius: _borderRadius,
          color: AppColors.kBlue3D6,
        ),
        child: Stack(
          children: <Widget>[
            Center(
              child: Text(widget.title ?? "Swipe to accept",
                  style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 16 * SizeConfig.textMultiplier!,
                      fontWeight: FontWeight.w700)),
            ),
            // AnimatedContainer(
            //   height: _buttonWidth,
            //   width: getPosition(constraints.maxWidth) + _buttonWidth,
            //   duration: Duration(milliseconds: _duration),
            //   curve: Curves.fastOutSlowIn,
            //   decoration: BoxDecoration(
            //     borderRadius: _borderRadius,
            //     color: _getSwipedColor(),
            //   ),
            // ),
            AnimatedPositioned(
              duration: Duration(milliseconds: _duration),
              curve: Curves.fastOutSlowIn,
              left: getPosition(constraints.maxWidth),
              child: GestureDetector(
                onPanUpdate: (details) =>
                    updatePosition(details, constraints.maxWidth),
                onPanEnd: (details) =>
                    swipeReleased(details, constraints.maxWidth),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 18 * SizeConfig.heightMultiplier!),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset: Offset(15 * SizeConfig.widthMultiplier!, 0),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.kWhite,
                          size: 25.0 * SizeConfig.imageSizeMultiplier!,
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-1 * SizeConfig.widthMultiplier!, 0),
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: AppColors.kWhite,
                          size: 25 * SizeConfig.imageSizeMultiplier!,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
