import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';

import '../../../utils/utils.dart';
import '../../../controllers/controllers.dart';
import '../../../config/config.dart';
import '../../../providers/providers.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _registerController = RegisterController();

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
          .register(this._registerController)
          .then(
        (value) {
          Loader.hide();
          if (value) {
            Scaffold.of(context).showSnackBar(
              UIHelpers.getSnackbar(
                message: 'Inscription effectuée avec succès !',
                backgroundColor: COLOR_GREEN,
                textColor: Colors.white,
                label: 'OK',
                action: () => {},
              ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.LOGIN,
              (r) => false,
            );
          } else {
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
          }
        },
      ).onError(
        (error, stackTrace) {
          Loader.hide();
          Scaffold.of(context).showSnackBar(
            UIHelpers.getSnackbar(
              message: 'Oups 😕... Une erreur est survenue, !',
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
                    controller: this._registerController.name,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le nom est obligatoire';
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
                      hintText: 'Nom',
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
                    controller: this._registerController.phoneNumber,
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
                      hintText: 'Numéro de telephone',
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
                    controller: this._registerController.pinCode,
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
                        return 'Le code PIN doit être composé de 4 chiffres !';
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
                    controller: this._registerController.pinCodeConfirm,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le code PIN de confirmation est obligatoire';
                      }
                      if (!isNumeric(value!)) {
                        return 'Veuillez spécifier un code PIN valide svp !';
                      }
                      if (value != this._registerController.pinCode.text) {
                        return 'Le code PIN et sa confirmation doivent être identiques !';
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
                      hintText: 'Confirmer Code PIN',
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
                      'S\'inscrire',
                      18,
                      FontWeight.w500,
                      () => this._onSubmit(),
                    ),
                  ),
                ),
                addVerticalSpace(5),
                customOutlinedButton(
                  'Retour à l\'identification',
                  COLOR_GREEN,
                  16,
                  FontWeight.w500,
                  () => Application.router.navigateTo(
                    context,
                    Routes.LOGIN,
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
