import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customText.dart';

class RoundButton extends SimpleButton {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final double? minWidth;
  final double? height;
  final double? fontSize;

  RoundButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.minWidth = 100,
    this.height = 45,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize,
  }) : super(
          key: key,
          text: text,
          minWidth: minWidth,
          height: height,
          color: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          textColor: textColor,
          onPressed: onPressed,
        );
}

class SimpleButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? color;
  final Color? textColor;
  final ShapeBorder? shape;
  final double? minWidth;
  final double? height;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? disabledColor;
  final ValueChanged<bool>? onFocusChanged;
  final Widget? child;
  final double? fontSize;

  const SimpleButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.child,
    this.color,
    this.textColor,
    this.shape,
    this.minWidth,
    this.disabledColor,
    this.focusColor,
    this.hoverColor,
    this.splashColor,
    this.height,
    this.onFocusChanged,
    this.fontSize,
  }) : super(key: key);

  @override
  _SimpleButtonState createState() => _SimpleButtonState();
}

class _SimpleButtonState extends State<SimpleButton> {
  final _focusNode = FocusNode();

  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      if (widget.onFocusChanged != null) {
        setState(() {
          widget.onFocusChanged!(_focusNode.hasFocus);
        });
      }
    });
    _focusNode.onKey = (FocusNode node, RawKeyEvent event) {
      if (event.isKeyPressed(LogicalKeyboardKey.escape) ||
          event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
          event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
        node.previousFocus();
        // if (!node.previousFocus()) {
        //   node.ancestors.last.previousFocus();
        // }
        return KeyEventResult.handled;
      } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
          event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
        node.nextFocus();
        // if (!node.nextFocus()) {
        //   node.descendants.first.nextFocus();
        // }
        return KeyEventResult.handled;
      }
      print("${node}  : ${event.physicalKey}");
      return KeyEventResult.ignored;
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: widget.minWidth,
      height: widget.height,
      color: widget.color,
      shape: widget.shape,
      focusNode: _focusNode,
      focusColor: widget.focusColor,
      hoverColor: widget.hoverColor,
      splashColor: widget.splashColor,
      disabledColor: widget.disabledColor,
      textColor: widget.textColor,
      onPressed: widget.onPressed,
      child: widget.child ??
          (_focusNode.hasFocus
              ? BoldText(
                  widget.text,
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                )
              : SimpleText(
                  widget.text,
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                )),
    );
  }
}
