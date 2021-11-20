import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

import '../../../utils/utils.dart';
import '../../../controllers/controllers.dart';
import '../../../config/config.dart';
import '../../../providers/providers.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _loginController = LoginController();
  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  void _onSubmit() {
    if (this._formKey.currentState!.validate()) {
      Loader.show(
        context,
        progressIndicator: CircularProgressIndicator(
          color: COLOR_GREEN,
        ),
      );
      context
          .read(authProvider.notifier)
          .getCodeOTP(this._loginController)
          .then(
        (value) {
          Loader.hide();
          if (value) {
            Scaffold.of(context).showSnackBar(
              UIHelpers.getSnackbar(
                message:
                    'Vous allez recevoir votre code, décodez le dans la section OTP décodeur !',
                backgroundColor: COLOR_GREEN,
                textColor: Colors.white,
                label: 'OK',
                action: () => {},
              ),
            );
            this._loginController.phoneNumber.text = '';
            // if we need to remove previous route in the RouteNavigatorStack instead of
            // router.navigateTo
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   Routes.HOME,
            //   (r) => false,
            // );
          } else {
            Scaffold.of(context).showSnackBar(
              UIHelpers.getSnackbar(
                message:
                    'Numéro de Telephone invalide ou n\'est pas enregistré !',
                backgroundColor: Colors.red,
                textColor: Colors.white,
                label: 'OK',
                action: () => {},
              ),
            );
          }
        },
      ).onError(
        (error, stackTrace) {
          Loader.hide();
          Scaffold.of(context).showSnackBar(
            UIHelpers.getSnackbar(
              message:
                  'Oups 😕... Une erreur est survenue, veuillez recommencer svp !',
              backgroundColor: Colors.red,
              textColor: Colors.white,
              label: 'OK',
              action: () => {},
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return Container(
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                addVerticalSpace(25),
                Container(
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: this._loginController.phoneNumber,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le numéro de telephone est obligatoire';
                      }
                      if (!isNumeric(value!)) {
                        return 'Veuillez spécifier un numéro de telephone valide svp !';
                      }
                    },
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 16,
                      color: COLOR_DARK,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20),
                      hintStyle: GoogleFonts.redHatDisplay(
                        fontSize: 16,
                        color: COLOR_DARK,
                      ),
                      hintText: 'Telephone',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: COLOR_DARK,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: COLOR_DARK,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
                addVerticalSpace(5),
                Container(
                  margin: EdgeInsets.all(15),
                  child: InkWell(
                    child: customTextButton(
                      COLOR_GREEN,
                      'Vérifier',
                      18,
                      FontWeight.w500,
                      () => this._onSubmit(),
                    ),
                  ),
                ),
                addVerticalSpace(5),
                customOutlinedButton(
                  'S\'inscrire',
                  COLOR_GREEN,
                  16,
                  FontWeight.w500,
                  () => Application.router.navigateTo(
                    context,
                    Routes.REGISTER,
                  ),
                ),
                addVerticalSpace(15),
              ],
            ),
          ),
        );
      },
    );
  }
}
