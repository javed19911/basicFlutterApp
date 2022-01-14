import 'package:basic_flutter_app/res/color.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customButton.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customText.dart';
import 'package:basic_flutter_app/utils/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../multiLanguage/lanuages/language.dart';
import '../../ui/base/BaseActivity.dart';
import '../../ui/login/vmLogin.dart';

import 'i_sign_up.dart';
import 'vm_sign_up.dart';

class SignUpActivity extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends BaseActivity<SignUpActivity, SignUpVM>
    implements ISignUp {
  SignUpVM? viewModel;
  var formKey = GlobalKey<FormState>();
  var progress;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  FocusNode _passwordNode = FocusNode();
  FocusNode _confirmPasswordNode = FocusNode();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _passwordNode.addListener(() {
      setState(() {
        _showPassword = !_passwordNode.hasFocus;
      });
    });

    _confirmPasswordNode.addListener(() {
      setState(() {
        _showConfirmPassword = !_confirmPasswordNode.hasFocus;
      });
    });
  }

  @override
  void onCreate() async {
    super.onCreate();
    var viewModel = getViewModel();
    if (viewModel != null) {
      viewModel.navigator = this;
    }
  }

  @override
  Widget getWidget(BuildContext buildContext, SignUpVM? vm) {
    this.viewModel = vm;
    //vm.checkIfAlreadyLoggedIn();
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          color: Colors.blue.shade50,
          padding: constraints.maxWidth < 500
              ? EdgeInsets.zero
              : const EdgeInsets.all(30.0),
          child: Stack(
            children: [
              Container(
                  child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  SizedBox(
                    height: 66,
                  ),
                  Logo(
                    // color: Colors.white,
                    textSize: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.blue,
                                      ), // icon is 48px widget.
                                    ),
                                    labelText: Language.of(context).email),
                                validator: checkEmptyValidation,
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                /*onChanged: (text) {
                                                      if (button_enabled != text.length >= 10) {
                                                        setState(() {
                                                          button_enabled = text.length >= 10;
                                                        });
                                                      }
                                                    },*/
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.blue,
                                      ), // icon is 48px widget.
                                    ),
                                    labelText: Language.of(context).mobile),
                                keyboardType: TextInputType.phone,
                                validator: phoneValidation,
                                maxLength: 10,
                                controller: _phoneController,
                                /*onChanged: (text) {
                                                      if (button_enabled != text.length >= 10) {
                                                        setState(() {
                                                          button_enabled = text.length >= 10;
                                                        });
                                                      }
                                                    },*/
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                focusNode: _passwordNode,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.password,
                                        color: Colors.blue,
                                      ), // icon is 48px widget.
                                    ),
                                    labelText: Language.of(context).password),
                                validator: checkPasswordValidation,
                                controller: _passwordController,
                                obscureText: _showPassword,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                focusNode: _confirmPasswordNode,
                                decoration: InputDecoration(
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(0.0),
                                      child: Icon(
                                        Icons.password,
                                        color: Colors.blue,
                                      ), // icon is 48px widget.
                                    ),
                                    labelText:
                                        Language.of(context).confirmPassword),
                                validator: passwordValidation,
                                controller: _confirmPasswordController,
                                obscureText: _showConfirmPassword,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: RoundButton(
                                  fontSize: 20,
                                  minWidth: 250,
                                  color: Colors.blue.shade400,
                                  text: Language.of(context).signUp,
                                  onPressed: () {
                                    if (vm?.mIsLoading != true) {
                                      if (formKey.currentState!.validate()) {
                                        vm?.createUser(
                                            buildContext,
                                            _emailController.text,
                                            _phoneController.text,
                                            _passwordController.text);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      openLoginActivity();
                    },
                    child: Text.rich(TextSpan(
                        text: Language.of(context).alreadyRegisteredUser,
                        // style: TextStyle(
                        //   color: Colors.red.shade500,
                        // ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: Language.of(context).signIn,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 12.sp,
                                color: Colors.blue,
                                height: 0.9,
                                decoration: TextDecoration.underline),
                          )
                        ])),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: SimpleText(
                      "UEnics©2021",
                      fontSize: 12,
                    ),
                  )
                ]),
              )),
              Center(
                child: vm?.mIsLoading == true
                    ? new CircularProgressIndicator()
                    : null,
              ),
            ],
          ));
    }));
  }

  String? checkEmptyValidation(value) {
    var regExp = RegExp(r'(^[a-z0-9]+@[a-z]+\.[a-z]{2,3})');

    if (value!.isEmpty || !regExp.hasMatch(value)) {
      return Language.of(context).enterValidEmail;
    }
    // if (value.isEmpty) {
    //   return Language.of(context).requiredWarningText;
    // }
    return null;
  }

  String? checkPasswordValidation(value) {
    if (value.isEmpty) {
      return Language.of(context).requiredWarningText;
    }
    return null;
  }

  String? passwordValidation(value) {
    if (value.isEmpty) {
      return Language.of(context).requiredWarningText;
    } else if (value != _passwordController.text) {
      return Language.of(context).enterSamePassword;
    }
    return null;
  }

  String? phoneValidation(value) {
    var regExp = RegExp(r'(^[5-9]\d{9}$)');

    if (value!.isEmpty || !regExp.hasMatch(value)) {
      return Language.of(context).enterValidMobile;
    }
    // if (value.isEmpty) {
    //   return Language.of(context).requiredWarningText;
    //   // } else if (value.toString().startsWith("+") &&
    //   //     value.toString().length != 13) {
    //   //   return "please enter valid phone number";
    // } else if (value.toString().length != 10) {
    //   return "please enter valid phone number";
    // }
    return null;
  }

  @override
  void openLoginActivity() {
    replaceNamedActivity("/");
  }
}
