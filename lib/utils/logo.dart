import 'package:basic_flutter_app/res/color.dart';
import 'package:basic_flutter_app/res/string/Strings.dart';
import 'package:flutter/material.dart';

import 'custom_widgets/customText.dart';

class Logo extends StatelessWidget {
  final Color? color;
  final double textSize;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry? padding;
  const Logo(
      {Key? key,
      this.color,
      this.textSize = 22,
      this.alignment = Alignment.center,
      this.padding = const EdgeInsets.all(7)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoldText(
            Strings.app_name,
            fontSize: textSize,
            alignment: TextAlign.center,
            color: color ?? CustomColors.darkGreen(),
          ),
          Container(
            color: color ?? CustomColors.darkGreen(),
            margin: EdgeInsets.only(top: 5),
            width: 50,
            height: 3,
          )
        ],
      ),
    );
  }
}
