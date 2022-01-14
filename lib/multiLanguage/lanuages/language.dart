import 'package:flutter/material.dart';

abstract class Language {
  static Language of(BuildContext context) {
    return Localizations.of(context, Language);
  }

  String get selectedLanguage;

  String get user;

  String get newUser;

  String get email;

  String get mobile;

  String get emailOrMobile;

  String get password;

  String get confirmPassword;

  String get login;

  String get signUp;

  String get signIn;

  String get logOut;

  String get proceed;

  String get forgotPassword;

  String get alreadyRegisteredUser;

  String get requiredWarningText;

  String get createNewLot;

  String get referAndEarn;

  String get watchHowToUseTheApp;

  String get contactUsOnWhatsapp;

  String get languagePreference;

  String get save;

  String get retake;

  String get addAnotherPhotos;

  String get percentage;

  String get photos;

  String get sendViaWhatsApp;

  String get my;

  String get today;

  String get date;

  String get addToContact;

  String get required;

  String get searchContacts;

  String get cancel;

  String get shareWithContacts;

  String get enterAgain;

  String get provideDetails;

  String get enterFirstName;

  String get enterLastName;

  String get emailAddress;

  String get contactNumber;

  String get enterValidEmail;

  String get enterValidMobile;

  String get enterSamePassword;

  String get loadingCategory;

  String get noCategoryFound;

  String get loadingItem;

  String get noItemFound;

  String get appSlogan;

  String get categories;

  String get viewAll;
}
