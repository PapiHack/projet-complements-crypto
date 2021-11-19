import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

import '../../../utils/utils.dart';
import '../../../controllers/controllers.dart';
import '../../../config/config.dart';
import '../../../providers/providers.dart';

class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _authController = AuthController();

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        return Container(
          color: COLOR_WHITE,
          child: Form(
            key: this._formKey,
            child: Column(
              children: [
                addVerticalSpace(25),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: this._authController.pinCode,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le code PIN est obligatoire';
                      }
                      if (!isNumeric(value!)) {
                        return 'Veuillez spécifier un code PIN valide svp !';
                      }
                      if (value.length != 4) {
                        return 'Le code PIN doit être composé de 4 chiffres';
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
                      hintText: 'Code PIN',
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
                addVerticalSpace(15),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: this._authController.codeOTP,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le code OTP est obligatoire';
                      }
                      if (!isNumeric(value!)) {
                        return 'Veuillez spécifier un code OTP valide svp !';
                      }
                      if (value.length != 6) {
                        return 'Le code OTP doit être composé de 6 chiffres !';
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
                      hintText: 'Code OTP',
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
                addVerticalSpace(15),
                Container(
                  margin: EdgeInsets.all(10),
                  child: InkWell(
                    child: customTextButton(
                      COLOR_GREEN,
                      'Se connecter',
                      18,
                      FontWeight.w500,
                      () => {},
                    ),
                  ),
                ),
                addVerticalSpace(5),
                customOutlinedButton(
                  'Retour à l\'identification',
                  COLOR_GREEN,
                  16,
                  FontWeight.w500,
                  () => {}
                  // () => Application.router.navigateTo(
                  //   context,
                  //   Routes.LOGIN,
                  // ),
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
