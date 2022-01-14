import 'package:basic_flutter_app/multiLanguage/lanuages/language.dart';
import 'package:flutter/material.dart';

enum Type { mobile, email, none }

class CustomFormTextField extends StatefulWidget {
  final String name;
  final Icon mobileIcon;
  final Icon emailIcon;
  final String mobileValidatorRegEx;
  final String emailValidatorsRegEx;
  final TextEditingController controller;

  const CustomFormTextField(
      {Key? key,
      required this.emailIcon,
      required this.emailValidatorsRegEx,
      required this.mobileIcon,
      required this.mobileValidatorRegEx,
      required this.controller,
      required this.name})
      : super(key: key);

  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  late RegExp regExp;
  Type selectedType = Type.none;
  bool isMobile = false;

  // String? Function(String?) validatorFunctionMaker() {
  //   return
  // }

  bool isNumeric(String? s) {
    if (s == null || s.isEmpty) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: isMobile ? widget.mobileIcon : widget.emailIcon,
          hintText: widget.name,
        ),
        onChanged: (_) {
          setState(() {
            if (_.isEmpty) {
              isMobile = false;
              selectedType = Type.none;
            } else if (isNumeric(_)) {
              isMobile = true;
              selectedType = Type.mobile;
            } else {
              isMobile = false;
              selectedType = Type.email;
            }
          });
        },
        validator: (value) {
          regExp = RegExp(
            selectedType == Type.email
                ? widget.emailValidatorsRegEx
                : selectedType == Type.mobile
                    ? widget.mobileValidatorRegEx
                    : "",
          );

          if (value!.isEmpty || !regExp.hasMatch(value)) {
            return selectedType == Type.mobile
                ? Language.of(context).enterValidMobile
                : Language.of(context).enterValidEmail;
          }
          // else if (!regExp.hasMatch(value)) {
          //   return "localization.pleaseEnterValidValue";
          // }
          return null;
        });
  }
}
