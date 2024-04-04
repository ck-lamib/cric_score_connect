import 'package:get/get.dart';

class Validators {
  static String? checkFieldEmpty(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if (trimmedContent.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  static String? checkPhoneField(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if (trimmedContent.isEmpty) {
      return 'This field is required';
    } else if (!(trimmedContent.isNumericOnly && trimmedContent.length == 10)) {
      return 'Invalid phone number';
    }

    return null;
  }

  static String? checkOptionalPhoneField(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if ((trimmedContent.isNotEmpty) &&
        !(trimmedContent.isNumericOnly && trimmedContent.length == 10)) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? checkPasswordField(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if (trimmedContent.isEmpty) {
      return 'This field is required';
    } else if (trimmedContent.length < 6) {
      return 'The password should be at least 6 digits';
    }

    return null;
  }

  static String? checkConfirmPassword(String? password, String? fieldContent) {
    var checkPassword = checkPasswordField(fieldContent);
    if (checkPassword != null) {
      return checkPassword;
    }

    if (password != fieldContent!) {
      return "Password does not match";
    }
    return null;
  }

  static String? checkEmailField(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if (trimmedContent.isEmpty) {
      return 'This field is required';
    } else if (!GetUtils.isEmail(trimmedContent.trim())) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkOptionalEmailField(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if ((trimmedContent.isNotEmpty) && !GetUtils.isEmail(trimmedContent)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? checkPinField(String? fieldContent) {
    var trimmedContent = fieldContent!.trim();
    if (trimmedContent.isEmpty) {
      return 'This field is required';
    } else if (!(trimmedContent.isNumericOnly && trimmedContent.length == 5)) {
      return 'Invalid OTP';
    }
    return null;
  }
}
