import 'dart:async';

import 'package:basic_flutter_app/res/color.dart';
import 'package:basic_flutter_app/res/string/Strings.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customButton.dart';
import 'package:basic_flutter_app/utils/custom_widgets/customText.dart';
import 'package:basic_flutter_app/utils/logo.dart';
import 'package:flutter/material.dart';
import '../../multiLanguage/lanuages/language.dart';
import '../../ui/base/BaseActivity.dart';
import '../../ui/login/vmLogin.dart';
import '../../utils/progessDialog.dart';

import '../../main.dart';
import 'iLogin.dart';

import 'dart:io' show Platform, exit;
import 'package:flutter/services.dart';

/*import 'dart:ui' as ui;
import 'dart:html' as html;
import 'dart:js' as js;*/

class LoginActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginActivity, vmLogin>
    implements iLogin {
  vmLogin? viewModel;
  var formKey = GlobalKey<FormState>();
  var progress;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ipController = TextEditingController();

  @override
  void onCreate() async {
    super.onCreate();
    var viewModel = getViewModel();
    if (viewModel != null) {
      viewModel.navigator = this;
      viewModel.checkIfAlreadyLoggedIn();
    }
  }

  @override
  Widget getWidget(BuildContext buildContext, vmLogin? vm) {
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
                  padding: EdgeInsets.only(top: 66.0),
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
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
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.blue,
                                          ), // icon is 48px widget.
                                        ),
                                        labelText: "Enter phone/email"),
                                    validator: checkEmptyValidation,
                                    controller: _usernameController,
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
                                    decoration: InputDecoration(
                                        prefixIcon: Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.password,
                                            color: Colors.blue,
                                          ), // icon is 48px widget.
                                        ),
                                        labelText:
                                            Language.of(context).passwordLabel),
                                    validator: checkEmptyValidation,
                                    controller: _passwordController,
                                    obscureText: true,
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
                                      text: Language.of(context).loginLabel,
                                      onPressed: () {
                                        if (vm?.mIsLoading != true) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            vm?.validateUser(
                                                buildContext,
                                                _usernameController.text,
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
                          openSignUpActivity();
                        },
                        child: Text.rich(TextSpan(text: 'New User? ',
                            // style: TextStyle(
                            //   color: Colors.red.shade500,
                            // ),
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'SignUp',
                                style: TextStyle(
                                    color: CustomColors.darkGreen(),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
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
                      ),
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
    if (value.isEmpty) {
      return Language.of(context).requiredWarningText;
    }
    return null;
  }

  @override
  void openHomeActivity() {
    replaceNamedActivity("/home");
  }

  @override
  void openSignUpActivity() {
    replaceNamedActivity("/signup");
  }

  // @override
  // void scaningLocalServer() {
  //   progress = showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return ProgressDialog(
  //           description: "Scanning for Local Server\nPlease wait..",
  //         );
  //       });
  // }
}
