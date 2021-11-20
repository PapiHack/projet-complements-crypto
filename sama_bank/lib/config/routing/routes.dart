import 'package:fluro/fluro.dart';

import 'handlers.dart';

class Routes {
  static FluroRouter? _instance;
  
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String HOME = '/home';
  static const String SIGN_IN = '/sign-in';

  static FluroRouter? getRouter() {
    if (_instance == null) {
      _instance = _configureRoutes();
    }
    return _instance;
  }

  static FluroRouter _configureRoutes() {
    final FluroRouter router = FluroRouter();
    router.define(LOGIN, handler: loginHandler, transitionType: TransitionType.fadeIn);
    router.define(REGISTER, handler: registerHandler, transitionType: TransitionType.inFromRight);
    router.define(HOME, handler: bankOperationsHandler, transitionType: TransitionType.inFromRight);
    router.define(SIGN_IN, handler: signInHandler, transitionType: TransitionType.nativeModal);
    return router;
  }
}