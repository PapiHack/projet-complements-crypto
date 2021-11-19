import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../services/services.dart';
import '../controllers/controllers.dart';

final AuthService authService = AuthService();

final authProvider = StateNotifierProvider((ref) => AuthNotifier(ref: ref));

class AuthNotifier extends StateNotifier<bool> {
  final ProviderReference ref;
  final bool isAuth;
  AuthNotifier({ this.isAuth: false, required this.ref }) : super(isAuth);

  Future<bool> login(AuthController authController) async {
    return await authService.login(authController);
  }

  Future<bool> register(RegisterController registerController) async {
    return await authService.register(registerController);
  }

  Future<bool> getCodeOTP(LoginController loginController) async {
    return await authService.getCodeOTP(loginController);
  }

  Future<CodeOTP?> decrypt(DecoderController decoderController) async {
    return await authService.decrypt(decoderController);
  }
}
