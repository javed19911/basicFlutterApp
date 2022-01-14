import 'package:basic_flutter_app/res/string/Strings.dart';
import 'package:basic_flutter_app/utils/custom_widgets/custom_form_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../main.dart';
import '../../multiLanguage/lanuages/language.dart';
import '../../ui/base/BaseActivity.dart';
import '../../ui/login/vmLogin.dart';

import 'iLogin.dart';

class LoginActivity extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends BaseActivity<LoginActivity, vmLogin>
    implements iLogin {
  vmLogin? viewModel;
  var _formKey = GlobalKey<FormState>();
  var selectedIndex = 0;
  var progress;
  var showPassword = true;

  final TextEditingController _emailOrMobileFieldController =
      TextEditingController();

  final TextEditingController _passFieldController = TextEditingController();

  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _ipController = TextEditingController();

  @override
  void onCreate() async {
    super.onCreate();
    var viewModel = getViewModel();
    if (viewModel != null) {
      viewModel.dataManager.getSelectedLanguage().then((locale) {
        setState(() {
          selectedIndex = locale.languageCode == "as"
              ? 2
              : locale.languageCode == "hi"
                  ? 1
                  : 0;
        });
      });
      viewModel.navigator = this;
      viewModel.checkIfAlreadyLoggedIn();
    }
  }

  @override
  Widget getWidget(BuildContext buildContext, vmLogin? vm) {
    this.viewModel = vm;
    //vm.checkIfAlreadyLoggedIn();
    return Scaffold(
        bottomSheet: Container(
          height: 290.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
          padding: EdgeInsets.all(20.w),
          child: Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.h),
                        Text(
                          Language.of(context).signIn,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                            color: Colors.black,
                            height: 0.9,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        CustomFormTextField(
                          emailIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          mobileIcon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                          emailValidatorsRegEx:
                              r'(^[a-z0-9]+@[a-z]+\.[a-z]{2,3})',
                          mobileValidatorRegEx: r'(^[5-9]\d{9}$)',
                          name: Language.of(context).emailOrMobile,
                          controller: _emailOrMobileFieldController,
                        ),
                        TextFormField(
                          obscureText: showPassword,
                          controller: _passFieldController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.password,
                                  color: Colors.grey,
                                ), // icon is 48px widget.
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(showPassword
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined),
                                onPressed: () async {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                              hintText: Language.of(context).password),
                          validator: (c) {
                            if (c!.isNotEmpty) {
                              return null;
                            }
                            return Language.of(context).password;
                          },
                        ),
                        SizedBox(height: 15.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 32.h),
                            textStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color: Colors.grey,
                              height: 0.9,
                            ),
                          ),
                          onPressed: () {
                            // openHomeActivity();
                            if (vm?.mIsLoading != true) {
                              if (_formKey.currentState!.validate()) {
                                vm?.validateUser(
                                    buildContext,
                                    _emailOrMobileFieldController.text,
                                    _passFieldController.text);
                              }
                            }
                          },
                          child: Text(Language.of(context).signIn),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Language.of(context).forgotPassword,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 11.sp,
                                color: Colors.blue,
                                height: 0.9,
                              ),
                            ),
                            SizedBox(width: 5.h),
                            InkWell(
                              onTap: () {
                                openSignUpActivity();
                              },
                              child: Text.rich(TextSpan(
                                  text: "${Language.of(context).newUser} ? ",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.sp,
                                    color: Colors.black,
                                    height: 0.9,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: Language.of(context).signUp,
                                      style: GoogleFonts.poppins(
                                          color: Colors.red,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline),
                                    )
                                  ])),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Text("UEnics©2021",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: Colors.grey,
                            height: 1.1,
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
              viewModel!.mIsLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Colors.amber,
                    ))
                  : Container()
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(25.w),
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/res/drawable/background.jpg"),
              opacity: 0.4,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ToggleSwitch(
                    minWidth: 90,
                    initialLabelIndex: selectedIndex,
                    totalSwitches: 3,
                    labels: const ['English', 'हिन्दी', 'অসমীয়া'],
                    onToggle: (index) {
                      selectedIndex = index;
                      if (index == 0) {
                        MyApp.setLocale(context, Locale('en'));
                      } else if (index == 1) {
                        MyApp.setLocale(context, Locale('hi'));
                      } else {
                        MyApp.setLocale(context, Locale('as'));
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 110.h,
              ),
              Text(
                Strings.app_name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 30.sp,
                  color: Colors.grey.shade500,
                  height: 0.9,
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                Language.of(context).appSlogan,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: Colors.grey,
                  height: 0.9,
                ),
              ),
            ],
          ),
        )
        /* LayoutBuilder(builder: (context, constraints) {
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        */ /*onChanged: (text) {
                                                      if (button_enabled != text.length >= 10) {
                                                        setState(() {
                                                          button_enabled = text.length >= 10;
                                                        });
                                                      }
                                                    },*/ /*
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
                                            labelText: Language.of(context)
                                                .passwordLabel),
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
        })*/
        );
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
