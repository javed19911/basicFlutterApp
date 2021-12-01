import 'package:basic_flutter_app/ui/dashboard/dashboard_activity.dart';
import 'package:basic_flutter_app/ui/dashboard/vm_dashboard.dart';
import 'package:basic_flutter_app/ui/signup/sign_up_activity.dart';
import 'package:basic_flutter_app/ui/signup/vm_sign_up.dart';
import 'package:flutter/material.dart';
import './ui/login/loginActivity.dart';
import './ui/login/vmLogin.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        // case '/login':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => vmLogin(),
                  child: LoginActivity(),
                ));
      // case '/':
      case '/signup':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => SignUpVM(),
                  child: SignUpActivity(),
                ));
      // case '/':
      case '/home':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (context) => DashboardVM(),
                  child: DashboardActivity(),
                ));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

enum Activity { LOGIN, MOVIE }
