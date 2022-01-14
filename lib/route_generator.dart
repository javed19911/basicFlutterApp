import 'package:basic_flutter_app/data/models/m_category.dart';
import 'package:basic_flutter_app/ui/dashboard/dashboard_activity.dart';
import 'package:basic_flutter_app/ui/dashboard/vm_dashboard.dart';
import 'package:basic_flutter_app/ui/details/details_activity.dart';
import 'package:basic_flutter_app/ui/signup/sign_up_activity.dart';
import 'package:basic_flutter_app/ui/signup/vm_sign_up.dart';
import 'package:flutter/material.dart';
import './ui/login/loginActivity.dart';
import './ui/login/vmLogin.dart';
import 'package:provider/provider.dart';

import 'ui/details/vm_details.dart';

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
      case '/details':
        if (args is CategoryM) {
          return MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider(
                    create: (context) => DetailsVM(args),
                    child: DetailsActivity(),
                  ));
        } else {
          return _errorRoute();
        }
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
