import 'package:email_validator/email_validator.dart';

class FormValidators {
  static String? emailValidator(String? value) {
    if (value != null) {
      return !EmailValidator.validate(value.trim())
          ? "Enter a valid email address"
          : null;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value != null) {
      return value.trim().length < 8
          ? "Password length must be atleast 8"
          : null;
    }
    return null;
  }

  static String? passwordConfirmValidator(
      String? password, String originalPassword) {
    if (password != null) {
      if (password.trim().length < 8) {
        return "Password length must be atleast 8";
      } else if (password.trim() != originalPassword.trim()) {
        return "The two passwords must match.";
      } else {
        return null;
      }
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value != null) {
      return value.trim().length < 9 ? "Enter a valid phone number" : null;
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value != null) {
      return value.trim().length < 4
          ? "Full Name length must be at least 4 characters"
          : null;
    }
    return null;
  }

  static String? isEmpty(String? value) {
    if (value == null) {
      return "Field can't be empty";
    } else {
      return value.trim().length < 1
          ? "This input must be at least 1 characters"
          : null;
    }
  }
}
