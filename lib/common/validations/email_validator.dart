import 'package:devel_app/common/resources/app_constants.dart';

String? emailValidator(String? text) {
  if (text == null || text.isEmpty) {
    return 'Campo requerido';
  }
  final emailRegexp = RegExp(AppConstants.emailRegexp);
  if (!emailRegexp.hasMatch(text)) {
    return 'El correo ingresado no es válido';
  }
  return null;
}
