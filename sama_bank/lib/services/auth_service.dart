import 'package:sama_bank/models/code_otp.dart';

import '../utils/utils.dart';
import '../controllers/controllers.dart';

class AuthService {
  final HttpClient httpClient = HttpClient();

  Future<bool> getCodeOTP(LoginController loginController) async {
    try {
      var response = await this.httpClient.post(
        '/generate-code',
        data: {
          'phoneNumber': loginController.phoneNumber.text,
        },
      );
      return response == null ? false : true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> register(RegisterController registerController) async {
    try {
      await this.httpClient.post(
        '/register',
        data: {
          'name': registerController.name.text,
          'phoneNumber': registerController.phoneNumber.text,
          'pin': cryptWithAES(registerController.pinCode.text),
        },
      );
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<CodeOTP?> decrypt(DecoderController decoderController) async {
    try {
      var response = await this.httpClient.post(
        '/decrypt-code',
        data: {
          'codeOTP': decoderController.codeToDecrypt.text,
        },
      );
      return CodeOTP.fromJSON(response);
    } catch (error) {
      return null;
    }
  }

  Future<bool> login(AuthController authController) async {
    try {
      await this.httpClient.post(
        '/login',
        data: {
          'pin': authController.pinCode.text,
          'codeOTP': authController.codeOTP.text,
        },
      );
      return true;
    } catch (error) {
      return false;
    }
  }
}
