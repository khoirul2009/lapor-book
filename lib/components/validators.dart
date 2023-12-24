import 'package:flutter/cupertino.dart';

String? notEmptyValidator(var value) {
  if(value == null || value.isEmpty) {
    return 'Kolom ini tidak boleh kososng';
  } else {
    return null;
  }
}

String? passwordConfirmationValidator(
    var value, TextEditingController passController
    ) {
  String? notEmpty = notEmptyValidator(value);
  if(notEmpty != null) {
    return notEmpty;
  }

  if(value.length < 6) {
    return 'Password minimal 6 karakter';
  }

  return null;

}