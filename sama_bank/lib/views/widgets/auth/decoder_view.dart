import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

import '../../../utils/utils.dart';
import '../../../controllers/controllers.dart';
import '../../../config/config.dart';
import '../../../providers/providers.dart';

class DecoderView extends StatefulWidget {
  @override
  _DecoderViewState createState() => _DecoderViewState();
}

class _DecoderViewState extends State<DecoderView> {
  final _formKey = GlobalKey<FormState>();

  final _decoderController = DecoderController();

  final _decodedOTPCodeController = TextEditingController();

  void _onSubmit() {
    Loader.show(
      context,
      progressIndicator: CircularProgressIndicator(
        color: COLOR_GREEN,
      ),
    );
    if (this._formKey.currentState!.validate()) {
      context.read(authProvider.notifier).decrypt(this._decoderController).then(
        (value) {
          Loader.hide();
          if (value != null) {
            this._decodedOTPCodeController.text = value;
            Scaffold.of(context).showSnackBar(
              UIHelpers.getSnackbar(
                message:
                    'Décodage effectué avec succés ! Veuillez utiliser ce code pour vous connecter !',
                backgroundColor: COLOR_GREEN,
                textColor: Colors.white,
                label: 'OK',
                action: () => {},
              ),
            );
          } else {
            Scaffold.of(context).showSnackBar(
              UIHelpers.getSnackbar(
                message: 'Code OTP invalide !',
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
                  'Oups 😕... Une erreur est survenue lors du décodage, veuillez recommencer svp !',
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
                    controller: this._decoderController.codeToDecrypt,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (isNull(value) || value == '') {
                        return 'Le code OTP à décrypter est obligatoire';
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
                      hintText: 'Code OTP à décoder',
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
                  margin: EdgeInsets.all(15),
                  child: TextFormField(
                    enabled: false,
                    enableInteractiveSelection: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: this._decodedOTPCodeController,
                    keyboardType: TextInputType.text,
                    validator: (value) {},
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
                      hintText: 'Valeur du Code OTP après décodage',
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
                      'Décoder',
                      18,
                      FontWeight.w500,
                      () => this._onSubmit(),
                    ),
                  ),
                ),
                addVerticalSpace(10),
                customOutlinedButton(
                  'Se connecter',
                  COLOR_GREEN,
                  16,
                  FontWeight.w500,
                  () => Application.router.navigateTo(
                    context,
                    Routes.SIGN_IN,
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
                addVerticalSpace(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
